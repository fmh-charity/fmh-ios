//  
//  MainScreenPresenter.swift
//  fmh
//
//  Created: 25.04.22
//

import UIKit

final class MainScreenPresenter {

    weak private var output: MainScreenPresenterOutput?
    
    var interactor: NewsInteractorProtocol?

    init(interactor: NewsInteractorProtocol, output: MainScreenPresenterOutput) {
        self.interactor = interactor
        self.output = output
    }
    
}

// MARK: - GeneralPresenterInput
extension MainScreenPresenter: MainScreenPresenterInput {
    
//    func getUserInfo(completion: @escaping (UserInfo?, NetworkError?) -> Void) {
//
//    }

}
