//
//  LoadingPresenter.swift
//  fmh
//
//  Created: 14.05.2022
//

<<<<<<< HEAD
import Foundation

final class LoadingPresenter {

    weak var output: LoadingPresenterOutput?
=======
import UIKit

final class LoadingPresenter {

    weak private var output: LoadingPresenterOutput?

    var isCompletion: (() -> ())?
    
    init(output: LoadingPresenterOutput) {
        self.output = output
    }
>>>>>>> develop
    
}

// MARK: - LoadingPresenterInput
extension LoadingPresenter: LoadingPresenterInput {
    
    func isDisplayed() {
<<<<<<< HEAD
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.output?.hide()
=======
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            self.isCompletion?()
>>>>>>> develop
        }
    }
    
}
