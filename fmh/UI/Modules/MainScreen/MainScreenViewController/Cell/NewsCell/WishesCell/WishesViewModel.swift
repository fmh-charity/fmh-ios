//
//  WishesViewModel.swift
//  fmh
//
//  Created: 26.06.22
//

import UIKit

class WishesViewModel {
    
    static let gmt = 0  // поправка на часовой пояс
    private var data = ""
    var indexOfColor = 0
    private(set) var taskDescription: String = ""
    private(set) var patientName: String = ""
    private(set) var executorName: String
    private(set) var plannedDate: String = ""
    private(set) var plannedTime: String = ""
    private(set) var color = CGColor(red: 0.0, green: 0.63, blue: 0.62, alpha: 1)
    private(set) var nameButton = ""

    private let wishesColor = [
        (CGColor(red: 0.81, green: 0.16, blue: 0.27, alpha: 1)),
        (CGColor(red: 0.93, green: 0.67, blue: 0.0, alpha: 1)),
        (CGColor(red: 0.0, green: 0.63, blue: 0.62, alpha: 1))
    ]
    
    
    init(wishes: Wishes) {
        taskDescription = wishes.title
        patientName = patiences[wishes.patientID].1
        executorName = executors[wishes.executorID].1
        plannedDate = convertDateFormater(date: wishes.planExecuteDate).0
        plannedTime = convertDateFormater(date: wishes.planExecuteDate).1
        data = createDate(date: wishes.planExecuteDate)
        color = calcColor().0
        nameButton = calcColor().1
    }
    
    func calcColor() -> (CGColor, String) {
        let dateFormatter = DateFormatter()
        let date = dateFormatter.date(from: data)
        
        self.indexOfColor = convertDateFormater(date: date ?? Date()).2
        switch indexOfColor {
        case  0...2:
            return (wishesColor[0], "VectorR")
        case 2..<6:
            return (wishesColor[1], "VectorW")
        case 6...1000:
            return (wishesColor[2], "VectorB")
        default:
            break
        }
        return (wishesColor[2], "VectorB")
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
    
    private func convertDateFormater(date: Date) -> (String, String, Int) {
        var year = 0
        var month = 0
        var day = 0
        var hour = 0
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = .init(secondsFromGMT: WishesViewModel.gmt)
//        guard let date = dateFormatter.date(from: date) else {
//            assert(false, "no date from string")
//            return ("", "", 0)
//        }
    
        var result = ("", "", 0)
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
                result.2 = resultHour
            }
        }
        dateFormatter.dateFormat = "HH:mm"
        let strTime = dateFormatter.string(from: date)
        result.1 = strTime
        
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let strData = dateFormatter.string(from: date)
        result.0 = strData
        return result
    }
 
}
    
