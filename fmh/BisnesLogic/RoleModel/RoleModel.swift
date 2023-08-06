//
//  RoleModel.swift
//  fmh
//
//  Created: 19.02.2023
//

import Foundation

/*
 
-    Нет
◙    Да
☼    Да, если автор
 
*/

//func test() {
//
//    if profile.checkAccess(.mainScreen) {
//
//    }
//
//}


enum RoleModel {
    
    // добавить функцию в слиента checkAccess() -> bool
    // возможно сделать синглтон Profile
    // ДОСТУПНЫЕ РОЛИ ЧИТАЕМ ИЗ ЕНУМА ПРИ ИНИТЕ И ПИШЕМ В ПЛИСТ!!!
    
    // проверять таблицу в плист и давать доступ
    // этот метод нужен в Profile или apiclient
    func executeIfAvailable(access: RoleModel.Access, completion: @escaping () -> Void) {
        
//        if access содержится в плист {
//            completion()
//        }
        
    }
}


// MARK: - Роли пользователей

extension RoleModel {
    
    enum Role: String {
        case administrator          = "Администратор системы"
        case medicalWorker          = "Медработник"
        case volunteer              = "Волонтер"
        case volunteerCoordinator   = "Координатор волонтеров"
        case patient                = "Пациент"
        case guest                  = "Гость"
    }
}

// MARK: - Точки доступа

extension RoleModel {
    
    enum Access: String {
        
        // Доступы главного меню ...
        case mainScreen          = "Главная страница"
        case newsScreen          = "Новости"
        case aboutHospiceScreen  = "О Хосписе"
        case ourMissionScreen    = "Наша миссия"
        case wishesScreen        = "Просьбы"
        case patientsScreen      = "Пациенты"
        case chambersScreen      = "Палаты"
        case postsScreen         = "Посты"
        case blocksScreen        = "Блоки"
        case usersScreen         = "Пользователи"
        case documentsScreen     = "Документы"
        case employeeScreen      = "Сотрудники"
        
        // Доступы основные ...
        
    }
}
