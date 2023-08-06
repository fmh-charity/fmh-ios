//
//  LoadingDependencies.swift
//  fmh
//
//  Created: 06.08.2023
//

import Foundation

struct LoadingDependencies {

    var readyToComplete: (() -> Void)?
    
    public init(readyToComplete: (() -> Void)? = nil) {
        self.readyToComplete = readyToComplete
    }
}
