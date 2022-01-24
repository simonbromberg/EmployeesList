//
//  NetworkProvider.swift
//  BlockEmployees
//
//  Created by Simon Bromberg on 2022-01-23.
//


import Foundation

private typealias ResponseData = [String: [Employee]]

extension ResponseData {
    var employees: [Employee]? {
        self["employees"]
    }
}

enum NetworkError: Error {
    case malformed
    case error(Error)
}

protocol DataProvider {
    func getEmployees() async throws -> [Employee]
}

extension DataProvider {
    func decode(_ data: Data) throws -> [Employee] {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        let jsonData = try decoder.decode(ResponseData.self, from: data)

        guard let employees = jsonData.employees else {
            throw NetworkError.malformed
        }

        return employees
    }
}

struct NetworkProvider: DataProvider {
    let baseURL: URL

    func getEmployees() async throws -> [Employee] {
        let (data, _) = try await URLSession.shared.data(from: baseURL)
        return try decode(data)
    }

    static var shared: Self {
        NetworkProvider(
            baseURL: URL(
                string: "https://s3.amazonaws.com/sq-mobile-interview/employees.json")!
        )
    }
}

struct MockProvider: DataProvider {
    enum File: String {
        case empty = "employees_empty"
        case normal = "employees"
        case malformed = "employees_malformed"
    }

    private let file: File

    init(file: File = .normal) {
        self.file = file
    }

    func getEmployees() async throws -> [Employee] {
        try await Task { () -> [Employee] in
            do {
                guard let url = Bundle.main.url(
                    forResource: "fixtures/\(file.rawValue)",
                    withExtension: "json"
                )
                else {
                    throw NetworkError.malformed
                }

                let data = try Data(contentsOf: url)
                return try decode(data)
            } catch {
                throw NetworkError.error(error)
            }
        }.result.get()
    }
}

