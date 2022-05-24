//
//  GeneralProtocols.swift
//  fmh
//
//  Created: 15.05.2022
//

import Foundation

// MARK: - GeneralPresenterInput
protocol GeneralPresenterInput: AnyObject {
<<<<<<< HEAD
    func getUserInfo ()
=======
    func getUserInfo(completion: @escaping (UserInfo?, APIError?) -> Void)
>>>>>>> develop
    func logOut ()
}


// MARK: - GeneralPresenterOutput
protocol GeneralPresenterOutput: AnyObject {
    var presenter: GeneralPresenterInput? { get set }
<<<<<<< HEAD
=======

>>>>>>> develop
}

// MARK: - GeneralViewControllerDelegate
protocol GeneralViewControllerDelegate: AnyObject {
    func logOut ()
}
