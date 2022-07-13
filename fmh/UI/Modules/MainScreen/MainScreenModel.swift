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
    var wishes: Wishes
    
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
    .init(createDate: Date(), creatorId: 0, creatorName: "thr", description: "rthhbfb fgvhfg fghb rthhbfb fgvhfg fghb rthhbfb fgvhfg fghb rthhbfb fgvhfg fghb", id: 0, newsCategoryId: 1, publishDate: Date(), publishEnabled: true, title: "rth"), .init(createDate: Date(), creatorId: 0, creatorName: "thr", description: "rthhbfb fgvhfg fghb rthhbfb fgvhfg fghb rthhbfb fgvhfg fghb rthhbfb fgvhfg fghb", id: 0, newsCategoryId: 1, publishDate: Date(), publishEnabled: true, title: "rth")
, .init(createDate: Date(), creatorId: 0, creatorName: "thr", description: "rthhbfb fgvhfg fghb rthhbfb fgvhfg fghb rthhbfb fgvhfg fghb rthhbfb fgvhfg fghb", id: 0, newsCategoryId: 1, publishDate: Date(), publishEnabled: true, title: "rth"), .init(createDate: Date(), creatorId: 0, creatorName: "thr", description: "rthhbfb fgvhfg fghb rthhbfb fgvhfg fghb rthhbfb fgvhfg fghb rthhbfb fgvhfg fghb", id: 0, newsCategoryId: 1, publishDate: Date(), publishEnabled: true, title: "rth"), .init(createDate: Date(), creatorId: 0, creatorName: "thr", description: "rthhbfb fgvhfg fghb rthhbfb fgvhfg fghb rthhbfb fgvhfg fghb rthhbfb fgvhfg fghb", id: 0, newsCategoryId: 1, publishDate: Date(), publishEnabled: true, title: "rth")
    , .init(createDate: Date(), creatorId: 0, creatorName: "thr", description: "rthhbfb fgvhfg fghb rthhbfb fgvhfg fghb rthhbfb fgvhfg fghb rthhbfb fgvhfg fghb", id: 0, newsCategoryId: 1, publishDate: Date(), publishEnabled: true, title: "rth")
]

// Test wishes

var wishesData: [Wishes] = [
    .init(createDate: Date(), creatorID: 1, description: "rcgr", executorID: 1, factExecuteDate: Date(), id: 1, patientID: 1, planExecuteDate: Date(), status: "OPEN", title: "Fghj")
//    Wishes(createDate: "2022-07-25T15:00:00.511Z", creatorID: creators[0].0, description: "сломана ножка", executorID: executors[0].0, factExecuteDate: "2022-07-25T12:00:00.511Z", id: 0, patientID: patiences[0].0, planExecuteDate: "2022-07-23T01:00:00.511Z", status: "OPEN", title: "починить кровать"),
//    Wishes(createDate: "2022-07-25T12:00:00.511Z", creatorID: creators[0].0, description: "изношен", executorID: executors[0].0, factExecuteDate: "2022-07-26T18:00:00.511Z", id: 0, patientID: patiences[1].0, planExecuteDate: "2022-07-26T12:00:00.511Z", status: "OPEN", title: "заменить матрац"),
//    Wishes(createDate: "2022-07-27T12:00:00.511Z", creatorID: creators[0].0, description: "падает полка", executorID: executors[0].0, factExecuteDate: "2022-07-27T12:00:00.511Z", id: 0, patientID: patiences[2].0, planExecuteDate: "2022-07-11T18:00:00.511Z", status: "OPEN", title: "починить шкаф"),
//    Wishes(createDate: "2022-06-27T12:00:00.511Z", creatorID: creators[0].0, description: "сильный сквозняк", executorID: executors[0].0, factExecuteDate: "2022-07-28T12:00:00.511Z", id: 0, patientID: patiences[3].0, planExecuteDate: "2022-07-30T12:00:00.511Z", status: "OPEN", title: "утеплить окно"),
//    Wishes(createDate: "2022-06-27T12:00:00.511Z", creatorID: creators[0].0, description: "расшатан стул", executorID: executors[0].0, factExecuteDate: "2022-07-28T12:00:00.511Z", id: 0, patientID: patiences[3].0, planExecuteDate: "2022-07-28T12:00:00.511Z", status: "OPEN", title: "заменить ножку"),
//    Wishes(createDate: "2022-07-27T12:00:00.511Z", creatorID: creators[0].0, description: "не открывается форточка", executorID: executors[0].0, factExecuteDate: "2022-07-28T12:00:00.511Z", id: 0, patientID: patiences[3].0, planExecuteDate: "2022-07-28T12:00:00.511Z", status: "OPEN", title: "починить форточку"),
//    Wishes(createDate: "2022-07-27T12:00:00.511Z", creatorID: creators[0].0, description: "заменить лампочку", executorID: executors[0].0, factExecuteDate: "2022-07-28T12:00:00.511Z", id: 0, patientID: patiences[3].0, planExecuteDate: "2022-07-26T12:00:00.511Z", status: "OPEN", title: "не горит лампа"),
//    Wishes(createDate: "2022-07-27T12:00:00.511Z", creatorID: creators[0].0, description: "починить тумбочку", executorID: executors[0].0, factExecuteDate: "2022-07-28T12:00:00.511Z", id: 0, patientID: patiences[3].0, planExecuteDate: "2022-07-21T12:00:00.511Z", status: "OPEN", title: "проблема с кроватью"),
//    Wishes(createDate: "2022-07-27T12:00:00.511Z", creatorID: creators[0].0, description: "починить светофор", executorID: executors[0].0, factExecuteDate: "2022-07-28T12:00:00.511Z", id: 0, patientID: patiences[3].0, planExecuteDate: "2022-07-15T12:00:00.511Z", status: "CLOSED", title: "проблема с светофором"),
//    Wishes(createDate: "2022-07-27T12:00:00.511Z", creatorID: creators[0].0, description: "починить ручку", executorID: executors[0].0, factExecuteDate: "2022-07-28T12:00:00.511Z", id: 0, patientID: patiences[3].0, planExecuteDate: "2022-07-18T12:00:00.511Z", status: "OPEN", title: "проблема с дверной ручкой"),
//    Wishes(createDate: "2022-07-27T12:00:00.511Z", creatorID: creators[0].0, description: "починить ручку", executorID: executors[0].0, factExecuteDate: "2022-07-28T12:00:00.511Z", id: 0, patientID: patiences[3].0, planExecuteDate: "2022-07-4T12:00:00.511Z", status: "CLOSED", title: "проблема с дверной ручкой")
]
