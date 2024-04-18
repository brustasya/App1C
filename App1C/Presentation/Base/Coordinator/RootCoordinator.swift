//
//  RootCoordinator.swift
//  App1C
//
//  Created by Станислава on 01.04.2024.
//

import UIKit

final class RootCoordinator: CoordinatorProtocol {
    private weak var window: UIWindow?
    
    private let authorizationAssembly: AuthorizationAssembly
    private let adminAssembly: AdminAssembly
    private let studentAssembly: StudentAssembly
    private let teacherAssembly: TeacherAssembly
    
    private let adminCoordinator: AdminCoordinator
    private let studentCoordinator: StudentCoordinator
    private let teacherCoordinator: TeacherCoordinator
    
    init(
        authorizationAssembly: AuthorizationAssembly,
        adminAssembly: AdminAssembly,
        studentAssembly: StudentAssembly,
        teacherAssembly: TeacherAssembly
    ) {
        self.authorizationAssembly = authorizationAssembly
        self.adminAssembly = adminAssembly
        self.studentAssembly = studentAssembly
        self.teacherAssembly = teacherAssembly
        
        adminCoordinator = AdminCoordinator(adminAssembly: adminAssembly)
        studentCoordinator = StudentCoordinator(studentAssembly: studentAssembly)
        teacherCoordinator = TeacherCoordinator(teacherAssembly: teacherAssembly)
    }
    
    func start(in window: UIWindow?) {
        self.window = window
        window?.rootViewController = authorizationAssembly.makeVerificationModule(moduleOutput: self)
        window?.makeKeyAndVisible()
        studentCoordinator.rootCoordinator = self
        teacherCoordinator.rootCoordinator = self
        adminCoordinator.rootCoordinator = self
    }
    
    func openRoleSelection() {
//        var roles = roles
//        roles.append(.student)
//        roles.append(.teacher)
        window?.rootViewController = authorizationAssembly.makeRoleSelectionModule(moduleOutput: self)
        
    }
    
    private func openStudentModule() {
        studentCoordinator.start(in: window)
    }
    
    private func openTeacherModule() {
        teacherCoordinator.start(in: window)
    }
    
    private func openAdminModule() {
        adminCoordinator.start(in: window)
    }
}

extension RootCoordinator: RoleSelectionModuleOutput {
    func userWantsToOpenStudentModule() {
        openStudentModule()
    }
    
    func userWantsToOpenTeacherModule() {
        openTeacherModule()
    }
    
    func userWantsToOpenAdminModule() {
        openAdminModule()
    }
}

extension RootCoordinator: VerificationModuleOutput, RootCoordinatorProtocol {
    func userWantsToOpenRoleSelection() {
        openRoleSelection()
    }
}

//extension RootCoordinator: RootCoordinatorProtocol {
//    func userWantsToOpenRoleSelection() {
//        openRoleSelection()
//    }
//}
