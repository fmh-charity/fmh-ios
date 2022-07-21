
import UIKit

struct TaskModel {
    let id = UUID()
    var nameOfTheme: String
    var nameOfExecutor: String
    var date: String
    var time: String
    var description: String
    var status:String
}

var taskModelCells = [
    TaskModel(nameOfTheme: "Это текст в три строчки с переносом текста по слогам", nameOfExecutor: "В.В Васильевич", date: "24.05.2022", time: "17:00", description: "fdskfsdnfknsdfknsdkf", status: "Open"),
    TaskModel(nameOfTheme: "День Виталий дверей Виталий дверей", nameOfExecutor: "В.В Васильевич", date: "24.05.2022", time: "17:00", description: "nfdskjnfsdkjnfkjnfsdfdsfdsf", status: "Work"),
    TaskModel(nameOfTheme: "1", nameOfExecutor: "В.В Васильевич", date: "24.05.2022", time: "17:00", description: "nfdskjnfsdkjnfkjnfsdfdsfdsf", status: "Open"),
    TaskModel(nameOfTheme: "День Виталий дверей Виталий дверей", nameOfExecutor: "В.В Васильевич", date: "24.05.2022", time: "17:00", description: "nfdskjnfsdkjnfkjnfsdfdsfdsf", status: "Work"),
    TaskModel(nameOfTheme: "День Виталий дверей Виталий дверей", nameOfExecutor: "В.В Васильевич", date: "24.05.2022", time: "17:00", description: "nfdskjnfsdkjnfkjnfsdfdsfdsf", status: "Complete"),
    TaskModel(nameOfTheme: "День Виталий дверей Виталий дверей", nameOfExecutor: "В.В Васильевич", date: "24.05.2022", time: "17:00", description: "nfdskjnfsdkjnfkjnfsdfdsfdsf", status: "Work"),
    TaskModel(nameOfTheme: "День Виталий дверей Виталий дверей", nameOfExecutor: "В.В Васильевич", date: "24.05.2022", time: "17:00", description: "nfdskjnfsdkjnfkjnfsdfdsfdsf", status: "Work"),
]



