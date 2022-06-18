//
//  GeneralPresenter.swift
//  fmh
//
//  Created: 15.05.2022
//

import Foundation

final class GeneralPresenter {

    weak private var output: GeneralPresenterOutput?
    
    var interactor: AuthInteractorProtocol?

    init(output: GeneralPresenterOutput) {
        self.output = output
    }
    
}

// MARK: - GeneralPresenterInput
extension GeneralPresenter: GeneralPresenterInput {
    
    func getUserInfo(completion: @escaping (UserInfo?, NetworkError?) -> Void) {
        interactor?.getUserInfo(completion: { userInfo, networkError in
            if let userInfo = userInfo {
                return completion(userInfo, nil)
            }
            return completion(nil, networkError)
        })
    }

}
