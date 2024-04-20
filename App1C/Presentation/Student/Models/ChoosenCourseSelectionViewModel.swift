//
//  ChoosenCourseSelectionViewModel.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import Foundation

final class ChoosenCourseSelectionViewModel {
    var allDeps: [ChoosenCourseView]
    let deps: [ChoosenCourseView]
    var nextView: ChoosenCourseView? = nil
    
    init(allDeps: [ChoosenCourseView], deps: [ChoosenCourseView]) {
        self.deps = deps
        self.allDeps = allDeps
    }
}
