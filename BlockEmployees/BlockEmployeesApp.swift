//
//  BlockEmployeesApp.swift
//  BlockEmployees
//
//  Created by Simon Bromberg on 2022-01-23.
//

import SwiftUI

@main
struct BlockEmployeesApp: App {
    var body: some Scene {
        WindowGroup {
            EmployeesListView(
                employeeService: EmployeeService(
                    dataProvider: MockProvider()
                )
            )
        }
    }
}
