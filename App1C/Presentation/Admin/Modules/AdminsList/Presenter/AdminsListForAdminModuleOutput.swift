//
//  AdminsListForAdminModuleOutput.swift
//  App1C
//
//  Created by Станислава on 18.04.2024.
//

import Foundation

protocol AdminsListForAdminModuleOutput: AnyObject {
    func moduleWantsToCloseAdminList()
    func moduleWantsToOpenAddAdmin()
    func moduleWantsToOpenAdminDetails(id: Int)
}
