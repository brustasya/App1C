//
//  CourseSelectionViewModel.swift
//  App1C
//
//  Created by Станислава on 14.04.2024.
//

import UIKit

final class CourseSelectionViewModel {
    var allDeps: [CourseView]
    let deps: [CourseView]
    var nextView: CourseView? = nil
    
    init(allDeps: [CourseView], deps: [CourseView]) {
        self.deps = deps
        self.allDeps = allDeps
    }
}
