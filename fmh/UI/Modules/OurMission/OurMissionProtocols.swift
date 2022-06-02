//
//  OurMissionProtocols.swift
//  fmh
//
//  Created: 6/2/22
//

import UIKit

// MARK: - OurMissionPresenterInput
protocol OurMissionPresenterInput: AnyObject {
}


// MARK: - OurMissionPresenterOutput
protocol OurMissionPresenterOutput: AnyObject {
    var presenter: OurMissionPresenterInput? { get set }
}

// MARK: - OurMissioniewControllerProtocol
protocol OurMissioniewControllerProtocol: BaseViewProtocol {
    var taglineView: UIView { get }
    var customTableView: UITableView { get }
    
}

// MARK: - OurMissionCellProtocol
protocol OurMissionCellProtocol {
    var isDescriptionHidden: Bool { get set}
}
