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
   
    func getAllNews(completion: @escaping ([News]?, NetworkError?) -> Void) {
        interactorNews?.getAllNews(completion: { news, networkError in
            guard networkError == nil else {
                //TODO: Обработка ошибки
                completion(nil, networkError)
                return
            }
            if let news = news {
                completion(news, nil)
                print(news.description)
            }
        })
    }
    
    func getAllWishes(completion: @escaping ([Wishes]?, NetworkError?) -> Void) {
        interactorWishes?.getAllwishes(completion: { wishes, networkError in
            guard networkError == nil else {
                //TODO: Обработка ошибки
                completion(nil, networkError)
                return
            }
            if let wishes = wishes {
                completion(wishes, nil)
                print(wishes.description)
            }
        })
    }
}


