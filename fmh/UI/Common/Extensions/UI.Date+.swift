//
//  UI.Date+.swift
//  fmh
//
//  Created: 19.12.2022
//

import Foundation

extension Date {

    var millisecondsSince1970: Int64 {
        Int64((self.timeIntervalSince1970 * 1000).rounded())
    }

    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }

    func toString(_ format: String = "dd.MM.yyy") -> String {
        let formater = DateFormatter()
        formater.dateFormat = format
        return formater.string(from: self)
    }

    func differenceByComponentsTo(_ toDate: Date = Date(), components: Set<Calendar.Component> = [.year, .month, .day, .hour, .minute, .second]) -> DateComponents {
        Calendar.current.dateComponents(components, from: self, to: toDate)
    }

}

