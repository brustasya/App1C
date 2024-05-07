//
//  StudentDiplomaViewOutput.swift
//  App1C
//
//  Created by Станислава on 07.05.2024.
//

import Foundation

protocol StudentDiplomaViewOutput: AnyObject {
    func viewIsReady()
    func viewWillAppear()
    func selectDegree(bachelor: Bool)
}
