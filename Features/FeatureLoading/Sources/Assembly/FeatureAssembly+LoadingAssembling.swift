//
//  FeatureAssembly+LoadingAssembling.swift
//  
//
//  Created by Константин Туголуков on 04.08.2023.
//

import UIKit

extension FeatureAssembly: LoadingAssembling {
    
    func makeLoadingViewController() -> UIViewController {
        let dataStorage = DataStorage()
        let viewController = LoadingViewController()
        let presenter = LoadingPresenter(dataStorage: dataStorage, view: viewController)
        viewController.presenter = presenter
        presenter.readyToComplete = dependencies.readyToComplete
        return viewController
    }
}
