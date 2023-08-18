//
//  FeatureDependencies.swift
//  
//
//  Created: 07.08.2023
//

import Foundation

public struct FeatureDependencies {

    public var onCompletion: (() -> Void)?
    
    public init(onCompletion: (() -> Void)? = nil) {
        self.onCompletion = onCompletion
    }
}
