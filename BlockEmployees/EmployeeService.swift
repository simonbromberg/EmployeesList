//
//  EmployeeService.swift
//  BlockEmployees
//
//  Created by Simon Bromberg on 2022-01-24.
//

import Combine
import Foundation
import SwiftUI

class EmployeeService: ObservableObject {
    @Published private(set) var isLoading: Bool = true
    @Published private(set) var employees: [Employee] = []
    @Published private(set) var error: Error?

    var updatedAt: Date = .distantPast

    private let dataProvider: DataProvider

    init(dataProvider: DataProvider) {
        self.dataProvider = dataProvider
    }

    @MainActor
    func fetch() async {
        isLoading = true
        defer {
            isLoading = false
            updatedAt = .now
        }

        do {
            employees = try await dataProvider.getEmployees().sorted(by: \.fullName)
        } catch {
            employees = []
            self.error = error
        }
    }
}

extension EmployeeService {
    var caption: Text {
        if isLoading {
            return Text("⏳ Loading…")
                .font(.caption)
        }
        if let error = error {
            return Text("🚨 Error loading employees: \(error.localizedDescription)")
                .font(.body)
                .foregroundColor(.red)
        }
        if employees.isEmpty {
            return Text("😬 No employees found. Get hiring!")
                .font(.body)
        }

        return Text("⌚️ Data updated \(updatedAt, formatter: DateFormatter.dateTime)")
            .font(.caption)
    }
}

private extension DateFormatter {
    static let dateTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .short
        return formatter
    }()
}

extension Sequence {
    /// Based on https://www.swiftbysundell.com/articles/the-power-of-key-paths-in-swift/
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>) -> [Element] {
        sorted { a, b in
            return a[keyPath: keyPath] < b[keyPath: keyPath]
        }
    }
}
