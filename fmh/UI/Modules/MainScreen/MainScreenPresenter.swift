//  
//  MainScreenPresenter.swift
//  fmh
//
//  Created: 25.04.22
//

import UIKit



final class MainScreenPresenter {
    
    weak private var output: MainScreenPresenterOutput?
    
    var interactorNews: NewsInteractorProtocol?
    var interactorWishes: WishesInteractorProtocol?

    init(output: MainScreenPresenterOutput) {
        self.output = output
    }
    
}

// MARK: - GeneralPresenterInput
extension MainScreenPresenter: MainScreenPresenterInput {
    
    func getNewsAll(completion: @escaping ([News]?, NetworkError?) -> Void) {
        interactorNews?.getAllNews(completion: { news, networkError in
            guard networkError == nil else {
                //TODO: Обработка ошибка
                completion(nil, networkError)
                return
            }
            if let news = news {
                completion(news, nil)
            }
        })
    }
    

}
