//
//  CourseSelectionModel.swift
//  App1C
//
//  Created by Станислава on 11.04.2024.
//

import UIKit

class CourseSelectionModel {
    public let id: Int
    public let title: String
    public let closed: Bool
    public var wasInLoad: Bool
    public weak var parentCourse: CourseSelectionModel?
    public var courseChildren: [CourseSelectionModel]
    public var views: [CourseView] = []
    
    init(id: Int, title: String, closed: Bool, wasInLoad: Bool = false, parentCourse: CourseSelectionModel? = nil, courseChildren: [CourseSelectionModel] = []) {
        self.id = id
        self.title = title
        self.closed = closed
        self.wasInLoad = wasInLoad
        self.parentCourse = parentCourse
        self.courseChildren = courseChildren
    }
}
