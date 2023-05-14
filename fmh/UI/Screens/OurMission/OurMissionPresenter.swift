//
//  UIModuleOurMissionPresenter.swift
//  fmh
//
//  Created: 6/2/22
//

import UIKit

protocol OurMissionPresenterProtocol {
    var dataArray: [OurMissionStruct] { get set }
}

protocol OurMissionPresenterDelegate: AnyObject {
    
}

final class OurMissionPresenter {

    weak private var view: OurMissionPresenterDelegate?

    /// Массив данных из файла OurMissionDataArray
    var dataArray: [OurMissionStruct]
    
    init(view: OurMissionPresenterDelegate) {
        self.view = view
        
        let dataStruct = OurMissionDataArray()
        self.dataArray = dataStruct.getData()
    }
}

extension OurMissionPresenter: OurMissionPresenterProtocol {

}
