//
//  StudentDetailsModel.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import Foundation

struct StudentDetailsModel: Codable {
    let secondName: String
    let firstName: String
    let surname: String?
    let telegram: String?
    let academicLeaveEndDate: String?
    let workplace: String?
    let job: String?
    let archive: Bool
    let inAcademicLeave: Bool
    let semester: Int?
    
    enum CodingKeys: String, CodingKey {
        case secondName = "second_name"
        case firstName = "first_name"
        case surname = "surname"
        case telegram = "telegram"
        case academicLeaveEndDate = "academic_leave_end_date"
        case workplace = "workplace"
        case job = "job"
        case archive = "archive"
        case inAcademicLeave = "in_academic_leave"
        case semester = "semester"
    }
}
