//
//  RouterProtocol.swift
//  fmh
//
//  Created: 22.05.2023
//

import UIKit

protocol RouterProtocol {
    func getWindowRootController() -> UIViewController?
    func setWindowRootController(with controller: UIViewController?)
    func setWindowRootNavigationController()
    func setRoot(_ screen: Presentable?, hideBar: Bool, animated: Bool)
    func push(_ screen: Presentable?, animated: Bool)
    func present(_ screen: Presentable?, animated: Bool, completion: (() -> Void)?)
    func pop(animated: Bool)
    func popToRoot(animated: Bool)
    func dismiss(animated: Bool, completion: (() -> Void)?)
}
