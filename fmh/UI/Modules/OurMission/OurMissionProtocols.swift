//
//  OurMissionProtocols.swift
//  fmh
//
//  Created: 6/2/22
//

import UIKit

// MARK: - OurMissionPresenterInput
protocol OurMissionPresenterInput: AnyObject {
    func toggleIsHidden(of index: Int)
    func getDataArray() -> [OurMissionStruct] 
}


// MARK: - OurMissionPresenterOutput
protocol OurMissionPresenterOutput: AnyObject {
    var presenter: OurMissionPresenterInput? { get set }
}

// MARK: - OurMissioniewControllerProtocol
protocol OurMissioniewControllerProtocol: BaseViewProtocol {
    
}

// MARK: - OurMissionCellProtocol
protocol OurMissionCellProtocol {
}
