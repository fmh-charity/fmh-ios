//
//  TemplatePresenter.swift
//  fmh
//
//  Created: 25.05.2022
//

import Foundation

final class TemplatePresenter {

    var interactor: NewsInteractorProtocol
    
    weak private var output: TemplatePresenterOutput?
    
    var isCompletion: (() -> ())?
    
    init(interactor: NewsInteractorProtocol, output: TemplatePresenterOutput) {
        self.interactor = interactor
        self.output = output
        
        loadTest()
    }
    
    private func loadTest() {
        interactor.getAllNews(completion: { news, apiError in
            guard apiError == nil else { return }
            print("itemsCount: \(news?.count)")
        })
    }
    
}

// MARK: - GeneralPresenterInput
extension TemplatePresenter: TemplatePresenterInput {
    
}
