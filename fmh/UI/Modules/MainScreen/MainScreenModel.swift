//
//  MainScreenModel.swift
//  fmh
//
//  Created: 26.04.22
//

import Foundation
import UIKit

struct MainScreenModel {
    var news: News
    var requests: Wishes
    
}

//struct News: {
//    var createDate: String = ""
//    var creatorID: Int = 0
//    var creatorName: String = ""
//    var description: String = ""
//    var id: Int = 0
//    var newsCategoryID: Int = 0
//    var publishDate: String = ""
//    var publishEnabled: Bool = true
//    var title: String = ""
//    var state: Bool = false
//
//}

struct Wishes {
    var createDate: String = ""
    var creatorID = 0
    var description = "string"
    var executorID = 0
    var factExecuteDate: String = ""
    var id = 0
    var patientID = 0
    var planExecuteDate: String = ""
    var status = "CANCELED"
    var title = "string"
}


//var test = MainScreenModel(news: News(), applications: Application())

//MARK: - Test arrays

// Test news



let patiences = [(0, "Тюрин П.Е."), (1, "Измайлов И.Н."), (2, "Трифонов B.H."), (3, "Ледак Т.И.")]
let creators = [(0, "Паратова R.H."), (1, "Иванова Т.М.")]
let executors = [(0, "Н.И.Ковалев"), (1, "Сталин И.В."), (2, "Ленин В.И."), (3, "Хрущёв Н.С.")]
let news = [(0, "С Днем Рождения Тюрина П.Е.С Днем Рождения Тюрина П.Е.С Днем Рождения Тюрина П.Е.С Днем Рождения Тюрина П.Е.С Днем Рождения Тюрина П.Е.С Днем Рождения Тюрина П.Е.С Днем Рождения Тюрина П.Е."), (1, "Встреча с волонтерами - Встреча с волонтерами - Встреча с волонтерами - Встреча с волонтерами - Встреча с волонтерами - Встреча с волонтерами - Встреча с волонтерами"), (2, "Выдача аванса сотрудникам - Выдача аванса сотрудникам - Выдача аванса сотрудникам - Выдача аванса сотрудникам - Выдача аванса сотрудникам"), (3, "Профсоюзное собрание - Профсоюзное собрание - Профсоюзное собрание - Профсоюзное собрание - Профсоюзное собрание - Профсоюзное собрание")]
let newsCategory = ["HappyBirthday", "TradeUnion", "Salary", "TradeUnion"]
let newsEvent = ["С Днем Рождения Тюрина П.Е.", "Встреча с волонтерами", "Выдача аванса", "Профсоюзное собрание"]

var newsData: [News] = [
    .init(createDate: Date(), creatorId: 0, creatorName: "thr", description: "rth", id: 0, newsCategoryId: 0, publishDate: Date(), publishEnabled: true, title: "rth")
    
]

// Test wishes

let wishesData = [
    Wishes(createDate: "2022-07-25T15:00:00.511Z", creatorID: creators[0].0, description: "сломана ножка", executorID: executors[0].0, factExecuteDate: "2022-07-25T12:00:00.511Z", id: 0, patientID: patiences[0].0, planExecuteDate: "2022-07-23T01:00:00.511Z", status: "OPEN", title: "починить кровать"),
    Wishes(createDate: "2022-07-25T12:00:00.511Z", creatorID: creators[0].0, description: "изношен", executorID: executors[0].0, factExecuteDate: "2022-07-26T18:00:00.511Z", id: 0, patientID: patiences[1].0, planExecuteDate: "2022-07-26T12:00:00.511Z", status: "OPEN", title: "заменить матрац"),
    Wishes(createDate: "2022-07-27T12:00:00.511Z", creatorID: creators[0].0, description: "падает полка", executorID: executors[0].0, factExecuteDate: "2022-07-27T12:00:00.511Z", id: 0, patientID: patiences[2].0, planExecuteDate: "2022-07-11T18:00:00.511Z", status: "OPEN", title: "починить шкаф"),
    Wishes(createDate: "2022-06-27T12:00:00.511Z", creatorID: creators[0].0, description: "сильный сквозняк", executorID: executors[0].0, factExecuteDate: "2022-07-28T12:00:00.511Z", id: 0, patientID: patiences[3].0, planExecuteDate: "2022-07-30T12:00:00.511Z", status: "OPEN", title: "утеплить окно"),
    Wishes(createDate: "2022-06-27T12:00:00.511Z", creatorID: creators[0].0, description: "расшатан стул", executorID: executors[0].0, factExecuteDate: "2022-07-28T12:00:00.511Z", id: 0, patientID: patiences[3].0, planExecuteDate: "2022-07-28T12:00:00.511Z", status: "OPEN", title: "заменить ножку"),
    Wishes(createDate: "2022-07-27T12:00:00.511Z", creatorID: creators[0].0, description: "не открывается форточка", executorID: executors[0].0, factExecuteDate: "2022-07-28T12:00:00.511Z", id: 0, patientID: patiences[3].0, planExecuteDate: "2022-07-28T12:00:00.511Z", status: "OPEN", title: "починить форточку"),
    Wishes(createDate: "2022-07-27T12:00:00.511Z", creatorID: creators[0].0, description: "заменить лампочку", executorID: executors[0].0, factExecuteDate: "2022-07-28T12:00:00.511Z", id: 0, patientID: patiences[3].0, planExecuteDate: "2022-07-26T12:00:00.511Z", status: "OPEN", title: "не горит лампа"),
    Wishes(createDate: "2022-07-27T12:00:00.511Z", creatorID: creators[0].0, description: "починить тумбочку", executorID: executors[0].0, factExecuteDate: "2022-07-28T12:00:00.511Z", id: 0, patientID: patiences[3].0, planExecuteDate: "2022-07-21T12:00:00.511Z", status: "OPEN", title: "проблема с кроватью"),
    Wishes(createDate: "2022-07-27T12:00:00.511Z", creatorID: creators[0].0, description: "починить светофор", executorID: executors[0].0, factExecuteDate: "2022-07-28T12:00:00.511Z", id: 0, patientID: patiences[3].0, planExecuteDate: "2022-07-15T12:00:00.511Z", status: "CLOSED", title: "проблема с светофором"),
    Wishes(createDate: "2022-07-27T12:00:00.511Z", creatorID: creators[0].0, description: "починить ручку", executorID: executors[0].0, factExecuteDate: "2022-07-28T12:00:00.511Z", id: 0, patientID: patiences[3].0, planExecuteDate: "2022-07-18T12:00:00.511Z", status: "OPEN", title: "проблема с дверной ручкой"),
    Wishes(createDate: "2022-07-27T12:00:00.511Z", creatorID: creators[0].0, description: "починить ручку", executorID: executors[0].0, factExecuteDate: "2022-07-28T12:00:00.511Z", id: 0, patientID: patiences[3].0, planExecuteDate: "2022-07-4T12:00:00.511Z", status: "CLOSED", title: "проблема с дверной ручкой")]


//class NewsViewModel {
//    
//    private(set) var imageName: String
//    private(set) var title: String
//    private(set) var date: String = ""
//    
//    init(news: News) {
//        imageName = newsCategory[news.newsCategoryID]
//        title = news.title
//        date = createDate(string: news.createDate)
//    }
//    
//    private func createDate(string: String) -> String {
//        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//        dateFormatter.timeZone = .none
//        guard let date = dateFormatter.date(from: string) else {
//            assert(false, "no date from string")
//            return ""
//        }
//        
//        dateFormatter.dateFormat = "dd MM yyyy"
//        dateFormatter.timeZone = NSTimeZone.system
//        let calcDate = dateFormatter.string(from: date)
//        return calcDate
//    }
    
    
    //func configureData(_ model: News) {
    //    self.newsIcon.image = UIImage(named: newsCategory[model.newsCategoryID])
     //   self.newsLabel.text = model.title
      //  self.newsDate.text = convertDateFormater(date: model.createDate)
      //  self.newsTextLabel.text = model.description
      //  self.isExpanded = model.state
      //  isExpanded ? (self.newsTextLabel.text = model.description) : (self.newsTextLabel.text = "")
       // print(isExpanded)
    //}
    

