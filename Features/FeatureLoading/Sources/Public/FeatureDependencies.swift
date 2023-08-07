//
//  FeatureDependencies.swift
//  
//
//  Created: 07.08.2023
//

import Foundation

public struct FeatureDependencies {

    var readyToComplete: (() -> Void)?
    
    public init(readyToComplete: (() -> Void)? = nil) {
        self.readyToComplete = readyToComplete
    }
}
