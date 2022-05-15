//
//  GeneralViewController.swift
//  fmh
//
//  Created: 14.05.2022
//

import Foundation
import UIKit

class GeneralViewController: UIViewController {
    
    var presenter: GeneralPresenterInput?
    
    var moduleFactory = ModuleFactory()

    weak var delegate: GeneralViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationBar()
        
        /// Default viewController
        showViewController(viewController: UIViewController())
    
    }
    
}

// MARK: - setNavigationBar
private extension GeneralViewController {
    
    func setNavigationBar() {

        var menuImageString = "line.horizontal.3"
        if #available(iOS 15.0, *) {
            menuImageString = "line.3.horizontal"
        }
        
        let menuButton = createBattonItem(
            image: UIImage(systemName: menuImageString),
            selector: nil)
        
        let ourMissionButton = createBattonItem(
            image: UIImage(named: "Butterfly.white"),
            selector: #selector(ourMissionButtonTap))
        
        let userButton = createBattonItem(
            image: UIImage(systemName: "person"),
            selector: #selector(userButtonTap))

        navigationItem.setLeftBarButton(menuButton, animated: true)
        navigationItem.rightBarButtonItems = [userButton, ourMissionButton]

        let titleView = createTitleview()
        navigationItem.titleView = titleView
        
        if #available(iOS 14.0, *) {
            menuButton.menu = uiMenu()
        } else {
            menuButton.action = #selector(menuButtonTap)
        }
        
    }
    
}

// MARK: - Selectors methods
private extension GeneralViewController {

    @objc func menuButtonTap () { self.present(alertActionMenu(), animated: true) }
    @objc func ourMissionButtonTap () { showViewController(viewController: UIViewController()) }
    @objc func userButtonTap () { self.present(alertActionUser(), animated: true) }
    
}

// MARK: - Genaric method ShowViewController
extension GeneralViewController {
    
    func showViewController<T>(viewController: T) where T: UIViewController {
        /// Update current viewController
        guard !self.children.contains(viewController) else {
            return
        }
        /// Deleted all children viewControllers
        for child in children {
            child.removeChildFromParent()
        }
        /// Add viewController in self viewController
        self.addChildViewController(viewController)
        /// Constraints child viewController in parent viewController
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        let margins = self.view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            viewController.view.topAnchor.constraint(equalTo: margins.topAnchor),
            viewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            viewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            viewController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }

}

// MARK: - Child operations
extension GeneralViewController: GeneralPresenterOutput {

}

// MARK: - Child operations
fileprivate extension UIViewController {
    
    func addChildViewController(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }
    
    func removeChildFromParent() {
        guard parent != nil else { return }
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
    
}
