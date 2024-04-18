//
//  PersonListViewOutput.swift
//  App1C
//
//  Created by Станислава on 09.04.2024.
//

import Foundation

protocol PersonListViewOutput: AnyObject {
    func viewIsReady()
    func selectedRowAt(index: Int)
}
