//
//  ChoosenCourseSelectionModel.swift
//  App1C
//
//  Created by Станислава on 20.04.2024.
//

import Foundation

class ChoosenCourseSelectionModel {
    public let id: Int
    public let title: String
    public var closed: Bool
    public var wasInLoad: Bool
    public weak var parentCourse: ChoosenCourseSelectionModel?
    public var courseChildren: [ChoosenCourseSelectionModel]
    public var views: [ChoosenCourseView] = []
    public var isStarted: Bool
    public var isOffline: Bool
    
    init(id: Int, title: String, closed: Bool, wasInLoad: Bool = false, parentCourse: ChoosenCourseSelectionModel? = nil, courseChildren: [ChoosenCourseSelectionModel] = [], isStarted: Bool, isOffline: Bool) {
        self.id = id
        self.title = title
        self.closed = closed
        self.wasInLoad = wasInLoad
        self.parentCourse = parentCourse
        self.courseChildren = courseChildren
        self.isStarted = isStarted
        self.isOffline = isOffline
    }
}
