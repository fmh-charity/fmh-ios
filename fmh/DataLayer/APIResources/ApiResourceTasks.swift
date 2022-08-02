//
//  ApiResourceTasks.swift
//  fmh
//
//  Created: 09.06.2022
//

import Foundation

enum APIResourceTasks {
    case getAllTasks                     // <- Реестр всех новостей
    case createTasks (task: DTOTask)        // <- Создание новой новости
    case refreshTasks (task: DTOTask)       // <- Обновляет информацию по новости
    case getTasks  (id: Int)             // <- Возвращает полную информацию по новости
    case removeTasks (id: Int)           // <- Удаление новости
    
    func resource<T: Decodable>() -> APIResource<T> {

        switch self {

            case .getAllTasks:
                return APIResource(path: "task",
                                   method: .get)

            case .createTasks(task: let task):
                return APIResource(path: "task",
                                   method: .post,
                                   body: task)
            case .refreshTasks(task: let task):

                return APIResource(path: "task",
                                   method: .put,
                                   body: task)

            case .getTasks(id: let id):

                return APIResource(path: "task/\(id)",
                                   method: .get)

            case .removeTasks(id: let id):
                return APIResource(path: "task/\(id)",
                                   method: .delete)
        }
    }
}
