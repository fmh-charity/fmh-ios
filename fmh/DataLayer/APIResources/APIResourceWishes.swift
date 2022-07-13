//
//  APIResourceWishes.swift
//  fmh
//
//  Created: 12.07.22
//

import Foundation

enum APIResourceWishes {
    
    case getAllWishes                         // <- Реестр всех просьб
    case createWishes (wishes: DTOWishes)         // <- Создание новой просьбы
    case refreshWishes (wishes: DTOWishes)        // <- Обновляет информацию по просьбе
    case getWishes  (id: Int)                 // <- Возвращает полную информацию по просьбе
    case removeWishes (id: Int)               // <- Удаление просьбы

    func resource<T: Decodable>() -> APIResource<T> {
        switch self {
            case .getAllWishes:
                return APIResource(path: "wishes",
                                   method: .get)
            
            case .createWishes(wishes: let wishes):
                return APIResource(path: "wishes",
                                   method: .post,
                                   body: wishes)
            
            case .refreshWishes(wishes: let wishes):
                return APIResource(path: "wishes",
                                   method: .put,
                                   body: wishes)
            
            case .getWishes(id: let id):
                return APIResource(path: "wishes/\(id)",
                                   method: .get)
            
            case .removeWishes(id: let id):
                return APIResource(path: "wishes/\(id)",
                                   method: .delete)
        }
    }
}

