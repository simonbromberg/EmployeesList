//
//  BlockEmployeesTests.swift
//  BlockEmployeesTests
//
//  Created by Simon Bromberg on 2022-01-23.
//

import XCTest
@testable import BlockEmployees

class NetworkProviderTests: XCTestCase {
    func testFetchEmployees() async {
        let dataProvider = MockProvider(file: .normal)
        do {
            let employees = try await dataProvider.getEmployees()
            XCTAssertEqual(employees.count, 11)
            let employee = try XCTUnwrap(employees.last, "Cannot get last employee")
            XCTAssertEqual(employee.fullName, "Jack Dorsey")
            XCTAssertEqual(employee.employeeType, .fullTime)
        } catch {}
    }

    func testFetchMalformedEmployees() async {
        let dataProvider = MockProvider(file: .malformed)

        var thrownError: Error?
        await XCTAssertThrowsError(
            try await dataProvider.getEmployees()
        ) {
            thrownError = $0
        }

        guard let thrownError = thrownError,
              case let NetworkError.error(error) = thrownError else {
                  XCTFail("Invalid error \(thrownError.debugDescription)")
                  return
        }

        XCTAssertTrue(error is Swift.DecodingError)
    }

    func testFetchEmptyEmployees() async {
        let dataProvider = MockProvider(file: .malformed)
        do {
            let employees = try await dataProvider.getEmployees()
            XCTAssertEqual(employees.count, 0)
        } catch {}
    }
}

// Copied from https://www.wwt.com/article/unit-testing-on-ios-with-async-await
extension XCTest {
    func XCTAssertThrowsError<T: Sendable>(
        _ expression: @autoclosure () async throws -> T,
        _ message: @autoclosure () -> String = "",
        file: StaticString = #filePath,
        line: UInt = #line,
        _ errorHandler: (_ error: Error) -> Void = { _ in }
    ) async {
        do {
            _ = try await expression()
            XCTFail(message(), file: file, line: line)
        } catch {
            errorHandler(error)
        }
    }
}
