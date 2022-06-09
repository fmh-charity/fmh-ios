//
//  TemplatePresenter.swift
//  fmh
//
//  Created: 25.05.2022
//

import Foundation

final class TemplatePresenter {

    weak private var output: TemplatePresenterOutput?
    
    var isCompletion: (() -> ())?
    
    init(output: TemplatePresenterOutput) {
        self.output = output
    }
}

// MARK: - GeneralPresenterInput
extension TemplatePresenter: TemplatePresenterInput {
    
}
