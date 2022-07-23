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
    private var viewController: MainScreenViewController?
    
    var news: [NewsViewModel] = [] {
        didSet {
            self.viewController?.newsItems = news
            output?.updatedNews()
        }
    }
    
    var wishes: [WishesViewModel] = [] {
        didSet {
            self.viewController?.wishesItems = wishes
            
        }
    }
    
    init(interactorNews: NewsInteractorProtocol, interactorWishes: WishesInteractorProtocol, output: MainScreenPresenterOutput,  viewController: MainScreenViewController) {
        self.viewController = viewController
        self.interactorNews = interactorNews
        self.interactorWishes = interactorWishes
        self.output = output
    }
    
}

// MARK: - GeneralPresenterInput
extension MainScreenPresenter: MainScreenPresenterInput {
    
        func getAllNews() {
        let count = self.viewController?.countNews
        interactorNews?.getAllNews { news, networkError in
            guard networkError == nil else {
                return
            }
            if let news = news {
                self.configureNewsItems(news: news, countNews: count!)
                
            }
        }
    }
    
    func getAllWishes() {
        let count = self.viewController?.countWishes
        interactorWishes?.getAllwishes{ wishes, networkError in
            guard networkError == nil else {
                return
            }
            if let wishes = wishes {
                self.configureWishesItems(wishes: wishes, countWishes: count!)
            }
        }
    }
    
    private func configureNewsItems(news: [News], countNews: Int) {
        var mapArray: [NewsViewModel] = []
        var resultArray: [NewsViewModel] = []
        news.forEach { if $0.publishEnabled == true {mapArray.append(.init(news: $0))}}
        let sortedArray = mapArray.sorted{ $0.estimatedHours < $1.estimatedHours }
        for index in 0..<sortedArray.count where index < countNews {
            resultArray.append(sortedArray[index])
        }
        self.news = resultArray                       // присваиваем отсортированный массив новостей
    }
    
    private func configureWishesItems(wishes: [Wishes], countWishes: Int) {
        var mapArray: [WishesViewModel] = []
        var resultArray: [WishesViewModel] = []
        wishes.forEach { if $0.status == "OPEN" || $0.status == "IN_PROGRESS" {mapArray.append(.init(wishes: $0))}}
        let sortedArray = mapArray.sorted{  $0.indexOfColor < $1.indexOfColor  }
        for index in 0..<sortedArray.count where index < countWishes {
            resultArray.append(sortedArray[index])
        }
        self.wishes = resultArray                    // присваиваем отсортированный массив просьб
    }
    
}

