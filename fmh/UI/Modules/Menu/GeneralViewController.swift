//
//  GeneralViewController.swift
//  fmh
//
//  Created: 14.05.2022
//

import Foundation
import UIKit

class GeneralViewController: UIViewController {
    
    // var moduleFactory: MainModuleFactory?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setNavigationBar()
        
        /// Default viewController
        //showViewController(viewController: ViewController())
    }
    
}

// MARK: - setNavigationBar
fileprivate extension GeneralViewController {
    
    func setNavigationBar() {
        
        let menuButton = createBattonItem(imageName: "phone", selector: #selector(menuButtonTap))
        navigationItem.setLeftBarButton(menuButton, animated: true)
        
        let userButton = createBattonItem(imageName: "phone", selector: #selector(userButtonTap))
        let ourMissionButton = createBattonItem(imageName: "phone", selector: #selector(ourMissionButtonTap))
        navigationItem.rightBarButtonItems = [userButton, ourMissionButton]
        
        let titleView = createTitleview()
        navigationItem.titleView = titleView
        
    }
    
}

// MARK: - Selectors methods
extension GeneralViewController {

    @objc func menuButtonTap () {}//{ showViewController(viewController: ViewController()) }
    @objc func userButtonTap () {}//{ showViewController(viewController: ViewController()) }
    @objc func ourMissionButtonTap () {}//{ showViewController(viewController: UIViewController()) }
    
}

// MARK: - Genaric method ShowViewController
fileprivate extension GeneralViewController {
    
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

// MARK: - UI elements
fileprivate extension GeneralViewController {
    
    func createTitleview() -> UIView {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 150, height: 44)
        
        let imageLogo = UIImageView()
        imageLogo.image = UIImage(named: "logo")
        imageLogo.frame = .init(x: 0, y: 0, width: view.frame.width, height: view.frame.height - 2) //view.frame.insetBy(dx: 0, dy: 2)
        imageLogo.contentMode = .scaleAspectFit
        
        view.addSubview(imageLogo)
       
        return view
    }
    
    func createBattonItem(imageName: String, selector: Selector) -> UIBarButtonItem {
        
        let button = UIButton(type: .system)
        button.setImage(
            UIImage(systemName: imageName)?.withRenderingMode(.alwaysTemplate),
            for: .normal)
        button.tintColor = .white
        button.imageView?.contentMode = .scaleAspectFit
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: selector, for: .touchUpInside)
        
        let barBattonItem = UIBarButtonItem(customView: button)
        return barBattonItem
    }
    
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
