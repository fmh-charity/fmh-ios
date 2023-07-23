//
//  DIFConfigurable.swift
//  fmh
//
//  Created: 31.05.2023
//

import Foundation

protocol DIFConfigurable {
    associatedtype ConfigurationModel
    func configure(with model: ConfigurationModel)
}
