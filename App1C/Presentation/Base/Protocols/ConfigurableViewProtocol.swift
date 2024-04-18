//
//  ConfigurableViewProtocol.swift
//  App1C
//
//  Created by Станислава on 03.04.2024.
//

import Foundation

protocol ConfigurableViewProtocol {
    associatedtype ConfigurationModel
    func configure(with model: ConfigurationModel)
}
