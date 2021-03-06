//
//  EmployeesListView.swift
//  BlockEmployees
//
//  Created by Simon Bromberg on 2022-01-23.
//

import CachedAsyncImage
import Combine
import SwiftUI

struct EmployeesListView: View {
    @StateObject var employeeService: EmployeeService
    @State private var showingConfirmation = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(employeeService.employees) { employee in
                        HStack {
                            EmployeeImage(urlString: employee.photoUrlSmall)
                                .frame(maxWidth: 50, maxHeight: 50)
                            VStack {
                                Text(employee.team)
                                    .font(.caption)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                Text(employee.fullName)
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
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
                employeeService.caption
            }
            .navigationTitle("Employees")
            .toolbar {
                Button("Sort") {
                    showingConfirmation = true
                }
                .confirmationDialog("Select sorting option…", isPresented: $showingConfirmation) {
                    ForEach(EmployeeService.SortOption.allCases, id: \.self) { option in
                        Button(option.title) {
                            employeeService.sort = option
                        }
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
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
