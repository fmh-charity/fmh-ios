//
//  AppAssemblyProtocol.swift
//  fmh
//
//  Created: 06.08.2023
//

import Foundation
import Features

protocol AppAssemblyProtocol: AnyObject {

    /// Сборки Feature модулей.
    var featuresAssembly: FeaturesAssemblyProtocol { get }
}
