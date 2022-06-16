//
//  DateHelper.swift
//  fmh
//
//  Created: 16.06.2022
//

import Foundation

func formatDateFromStringToInt(date: String, time: String) -> Int {
    let own = date + " " + time
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyyy hh:mm"
    let nashaData = dateFormatter.date(from: own)
    guard let data = nashaData else { return 0 }
    let timeInterval = data.timeIntervalSince1970
    let myInt = Int(timeInterval)
    return myInt
}

func formatDateFromIntToString(_ int : Int) -> (String, String) {
    let timeInterval = TimeInterval(int)
    let myNSDate = Date(timeIntervalSince1970: timeInterval)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd.MM.yyyy hh:mm"
    let nashaData = dateFormatter.string(from: myNSDate)
    let dateAndTime = nashaData.components(separatedBy: " ")
    return (dateAndTime[0], dateAndTime[1])
}

func getCurrentDate() -> Int {
    let currentDate = Date()
    let timeInterval = currentDate.timeIntervalSince1970
    let myInt = Int(timeInterval)
    return myInt
}
