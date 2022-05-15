//
//  LoadingPresenter.swift
//  fmh
//
//  Created: 14.05.2022
//

import Foundation

final class LoadingPresenter {

    weak var output: LoadingPresenterOutput?
    
}

// MARK: - LoadingPresenterInput
extension LoadingPresenter: LoadingPresenterInput {
    
    func isDisplayed() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.output?.hide()
        }
    }
    
}
