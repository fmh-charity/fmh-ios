//
//  ViewInputDelegate.swift
//  fmh
//
//  Created: 07.07.2022
//

import Foundation

protocol ViewInputDelegate: AnyObject {
    func setupInitialState()
    func setupData(with testData: ([LoadingScreenModel]))
    func displayData(i: Int)
}
