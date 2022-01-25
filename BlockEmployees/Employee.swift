//
//  Employee.swift
//  BlockEmployees
//
//  Created by Simon Bromberg on 2022-01-23.
//

import Foundation

struct Employee: Decodable, Identifiable, Hashable {
    var id: String {
        uuid
    }

    let uuid: String
    let fullName: String
    let phoneNumber: String?
    let emailAddress: String
    let biography: String?
    let photoUrlSmall: String?
    let photoUrlLarge: String?
    let team: String
    let employeeType: EmployeeType

    enum EmployeeType: String, Decodable, CustomStringConvertible {
        case fullTime = "FULL_TIME"
        case partTime = "PART_TIME"
        case contractor = "CONTRACTOR"

        var description: String {
            switch self {
            case .fullTime:
                return "Full-time"
            case .partTime:
                return "Part-time"
            case .contractor:
                return "Contractor"
            }
        }
    }
}
