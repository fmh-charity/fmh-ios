//
//  NewsViewModel.swift
//  fmh
//
//  Created: 25.06.22
//

import Foundation
import UIKit

class NewsViewModel {
    
    private(set) var imageName = UIImage()
    private(set) var title: String = ""
    private(set) var date: String = ""
    private(set) var text: String = ""
    private(set) var image = "ArrowDown"
    var isExpanded = false
    var estimatedHours = 0
    
    
    init(news: News) {
        if let image = news.categoryImg{ imageName = image }
        title = news.title
        date = createDate(date: news.publishDate)
        text = news.description
        estimatedHours = convertDateFormater(date: news.publishDate)
    }

    private func createDate(date: Date) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = .none

        
        dateFormatter.dateFormat = "dd MM yyyy"
        dateFormatter.timeZone = NSTimeZone.system
        let calcDate = dateFormatter.string(from: date)
        return calcDate
    }
    
    private func convertDateFormater(date: Date) -> Int {
        var year = 0
        var month = 0
        var day = 0
        var hour = 0
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = .init(secondsFromGMT: WishesViewModel.gmt)

        var result = 0
        dateFormatter.dateFormat = "yyyy"
        if let temp = Int(dateFormatter.string(from: date)) { year = temp } else { year = 0 }
        dateFormatter.dateFormat = "MM"
        if let temp = Int(dateFormatter.string(from: date)) { month = temp } else { month = 0 }
        dateFormatter.dateFormat = "dd"
        if let temp = Int(dateFormatter.string(from: date)) { day = temp } else { day = 0 }
        dateFormatter.dateFormat = "HH"
        if let temp = Int(dateFormatter.string(from: date)) { hour = temp } else { hour = 0 }
        
        let dateCoponents = DateComponents(year: year, month: month, day: day, hour: hour)
        if let nextDate = Calendar.current.nextDate(after: Date(), matching: dateCoponents, matchingPolicy: .nextTime) {
            let difference = Calendar.current.dateComponents([.hour], from: Date(), to: nextDate)
            if let resultHour = difference.hour {
                result = resultHour
            }
        }
        return result
    }
    
}
