//
//  SelectCourseItemDelegate.swift
//  App1C
//
//  Created by Станислава on 17.05.2024.
//

import Foundation

protocol SelectCourseItemDelegate: AnyObject {
    func selectItem(id: Int)
    func unSelectItem(id: Int)
    func getInfo(id: Int)
}
