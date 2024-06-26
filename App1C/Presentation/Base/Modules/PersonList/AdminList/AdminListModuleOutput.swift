//
//  AdminListModuleOutput.swift
//  App1C
//
//  Created by Станислава on 09.04.2024.
//

import Foundation

protocol AdminListModuleOutput: AnyObject {
    func moduleWantsToCloseAdminList()
    func moduleWantsToOpenAdminDetails(id: Int)
}
