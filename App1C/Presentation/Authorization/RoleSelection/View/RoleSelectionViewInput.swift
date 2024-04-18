//
//  RoleSelectionViewInput.swift
//  App1C
//
//  Created by Станислава on 02.04.2024.
//

import Foundation

protocol RoleSelectionViewInput: AnyObject {
    func showRoles(roles: [BaseModel])
}
