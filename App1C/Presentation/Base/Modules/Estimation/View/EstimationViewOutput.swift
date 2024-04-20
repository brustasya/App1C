//
//  EstimationViewOutput.swift
//  App1C
//
//  Created by Станислава on 21.04.2024.
//

import Foundation

protocol EstimationViewOutput: AnyObject {
    func finishEstimating()
    func estimate(id: Int, grade: Int)
    func viewIsReady()
}
