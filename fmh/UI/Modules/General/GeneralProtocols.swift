//
//  GeneralProtocols.swift
//  fmh
//
//  Created: 15.05.2022
//

import UIKit

// MARK: - GeneralPresenterInput
protocol GeneralPresenterInput: AnyObject {
    func getUserInfo(completion: @escaping (UserInfo?, NetworkError?) -> Void)
}


// MARK: - GeneralPresenterOutput
protocol GeneralPresenterOutput: AnyObject {
    var presenter: GeneralPresenterInput? { get set }
}

// MARK: - GeneralViewControllerProtocol
protocol GeneralViewControllerProtocol: BaseViewProtocol {
    var contextViewController: UIViewController? { get set }
    var didSelectMenu: ((_ menuOptions: GeneralMenu) -> ())? { get set }
    var didSelectAdditionalMenu: ((_ menuOptions: GeneralMenu.AdditionalMenu) -> ())? { get set }
}
