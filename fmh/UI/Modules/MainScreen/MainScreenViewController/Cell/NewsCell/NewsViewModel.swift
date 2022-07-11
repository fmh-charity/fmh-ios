//
//  NewsViewModel.swift
//  fmh
//
//  Created: 25.06.22
//

import Foundation

class NewsViewModel {
    
    private(set) var imageName: String = ""
    private(set) var title: String = ""
    private(set) var date: String = ""
    private(set) var text: String = ""
    private(set) var image = "ArrowDown"
    var isExpanded = false
    var estimatedHours = 0
    
    
    init(news: News) {
//        imageName = newsCategory[news.newsCategoryID]
//        title = news.title
//        date = createDate(string: news.publishDate)
//        text = news.description
//        estimatedHours = convertDateFormater(date: news.publishDate)
    }

    private func createDate(string: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = .none
        guard let date = dateFormatter.date(from: string) else {
            assert(false, "no date from string")
            return ""
        }
        
        dateFormatter.dateFormat = "dd MM yyyy"
        dateFormatter.timeZone = NSTimeZone.system
        let calcDate = dateFormatter.string(from: date)
        return calcDate
    }
    
    private func convertDateFormater(date: String) -> Int {
        var year = 0
        var month = 0
        var day = 0
        var hour = 0
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = .init(secondsFromGMT: WishesViewModel.gmt)
        guard let date = dateFormatter.date(from: date) else {
            assert(false, "no date from string")
            return 0
        }
    
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
