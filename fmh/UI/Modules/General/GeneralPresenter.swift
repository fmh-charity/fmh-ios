//
//  GeneralPresenter.swift
//  fmh
//
//  Created: 15.05.2022
//

import Foundation

final class GeneralPresenter {

<<<<<<< HEAD
    weak var output: GeneralPresenterOutput?
    
    var repository: AuthRepositoryProtocol?
=======
    weak private var output: GeneralPresenterOutput?
    
    var interactor: AuthInteractorProtocol?
    
    var isCompletion: (() -> ())?
    
    init(output: GeneralPresenterOutput) {
        self.output = output
    }
>>>>>>> develop
    
}

// MARK: - GeneralPresenterInput
extension GeneralPresenter: GeneralPresenterInput {
    
<<<<<<< HEAD
    func getUserInfo() {
        
    }
    
    func logOut() {
        AppSession.logOut()
=======
    func getUserInfo(completion: @escaping (UserInfo?, APIError?) -> Void) {
        interactor?.getUserInfo(completion: { userInfo, apiError in
            if let userInfo = userInfo {
                return completion(userInfo, nil)
            }
            return completion(nil, apiError)
        })
    }
    
    func logOut() {
        self.interactor?.logOut()
        self.isCompletion?()
>>>>>>> develop
    }
    
}
