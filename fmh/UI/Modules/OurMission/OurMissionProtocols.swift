//
//  OurMissionProtocols.swift
//  fmh
//
//  Created: 6/2/22
//

import UIKit

// MARK: - OurMissionPresenterInput
protocol OurMissionPresenterInput: AnyObject {
    var dataArray: [OurMissionStruct] { get set }
}


// MARK: - OurMissionPresenterOutput
protocol OurMissionPresenterOutput: AnyObject {
    var presenter: OurMissionPresenterInput? { get set }
}

// MARK: - OurMissioniewControllerProtocol
protocol OurMissionViewControllerProtocol: BaseViewProtocol {
}
