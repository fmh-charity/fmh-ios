//
//  ScreenFactory+Loading.swift
//  fmh
//
//  Created: 26.11.2022
//

import Foundation

protocol LoadingScreenFactoryProtocol {
    /// Make  LoadingViewController
    func makeLoadingViewController() -> LoadingViewControllerProtocol
}


//MARK: - LoadingScreenFactoryProtocol
extension ScreenFactory: LoadingScreenFactoryProtocol {
    
    func makeLoadingViewController() -> LoadingViewControllerProtocol {
        let viewController = LoadingViewController()
        return viewController
    }
    
}
