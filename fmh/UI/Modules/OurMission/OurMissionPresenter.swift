//
//  OurMissionPresenter.swift
//  fmh
//
//  Created: 6/2/22
//

import UIKit

/// Структура ячейки
struct OurMissionStruct {
    /// Главная строка ячейки, которая не скрывается
    let tagline: String
    /// Строка, которая раскрывается/скрывается при нажатии на ячейку
    let more: String
    /// Цвет фона главной строки ячейки
    let color: UIColor
    /// Маркер ячейки (скрыта/раскрыта)
    var isHidden: Bool
}

final class OurMissionPresenter {

    weak private var output: OurMissionPresenterOutput?

    /// Массив данных из файла OurMissionDataArray
    var dataArray: [OurMissionStruct]
    
    init(output: OurMissionPresenterOutput) {
        self.output = output
        
        let dataStruct = OurMissionDataArray()
        self.dataArray = dataStruct.getData()
    }
}

extension OurMissionPresenter: OurMissionPresenterInput {

}
