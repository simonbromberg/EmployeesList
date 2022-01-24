//
//  EmployeesListView.swift
//  BlockEmployees
//
//  Created by Simon Bromberg on 2022-01-23.
//

import Combine
import SwiftUI

class EmployeeService: ObservableObject {
    @Published private(set) var isLoading: Bool = false
    @Published private(set) var employees: [Employee] = []
    @Published private(set) var error: Error?

    var updatedAt: Date = .distantPast

    let dataProvider: DataProvider

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
            employees = try await dataProvider.getEmployees()
        } catch {
            employees = []
            self.error = error
        }
    }
}

extension EmployeeService {
    var caption: String? {
        if isLoading {
            return "⏳ Loading…"
        }
        if let error = error {
            return "🚨 Error loading employees: \(error.localizedDescription)"
        }
        if employees.isEmpty {
            return "😬 No employees found. Get hiring!"
        }

        return "⌚️ Data updated \(updatedAt.description(with: .current))" // FIXME: formatter
    }
}

struct EmployeesListView: View {
    @StateObject var employeeService: EmployeeService
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(employeeService.employees) { employee in
                        HStack {
                            Text(employee.fullName)
                                .font(.headline)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            Text(employee.employeeType.description)
                                .font(.subheadline)
                        }
                    }
                }
                .task {
                    await employeeService.fetch()
                }
                .refreshable {
                    await employeeService.fetch()
                }
                Text(employeeService.caption ?? "")
                    .font(.caption)
                    .foregroundColor(employeeService.error != nil ? .red : .primary)
            }
            .navigationTitle("Employees")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        EmployeesListView(
            employeeService: EmployeeService(
                dataProvider: MockProvider()
            )
        )
        EmployeesListView(
            employeeService: EmployeeService(
                dataProvider: MockProvider(file: .empty)
            )
        )
        EmployeesListView(
            employeeService: EmployeeService(
                dataProvider: MockProvider(file: .malformed)
            )
        )
    }
}
