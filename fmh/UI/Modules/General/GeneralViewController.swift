//
//  GeneralViewController.swift
//  fmh
//
//  Created: 21.05.2022
//

import Foundation
import UIKit

class GeneralViewController: UIViewController {
    
    var presenter: GeneralPresenterInput?
    var contextNavigationController: UINavigationController?
    
    private var isActiveMenu: Bool = false
    private var menuViewController = GeneralMenuViewController()
    private var contextViewController = GeneralContextViewController()
    
    /// Тут добавляем дочернии ViewController
    // var mainViewController = MainViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        
        addChildViewControllers ()
    }
    
    private func addChildViewControllers () {
        guard let contextNavigation = contextNavigationController else {
            // TODO: Выводить экран заглушку
            return
        }
        /// Добавляем меню
        menuViewController.delegate = self
        addChildViewController(menuViewController)
        
        /// Добавляем основно контейнер (где отображаются ViewControllers)
        contextViewController.delegate = self
        contextNavigation.setViewControllers([contextViewController], animated: false)
        addChildViewController(contextNavigation)
        
        /// По умолчанию ViewController
        //setContextViewController(viewController: vc)
    }
    
}

//MARK: - GeneralContextViewControllerDelegate
extension GeneralViewController: GeneralContextViewControllerDelegate {
    func didTapMenuButton() {
        toggleMenu(completion: nil)
    }
    
    private func toggleMenu (completion: (() -> Void)?) {
        switch isActiveMenu {
        case false:
            /// open
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut) { [weak self] in
                guard let context = self?.contextNavigationController else { return }
                context.view.frame.origin.x = context.view.frame.size.width - 100
                //TODO: Добавить обработчик нажатия и притемнять
                
            } completion: { [unowned self] done in
                if done {
                    self.isActiveMenu = true
                }
            }
        case true:
            /// close
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut) { [weak self] in
                guard let context = self?.contextNavigationController else { return }
                context.view.frame.origin.x = 0
            } completion: { [unowned self] done in
                if done {
                    self.isActiveMenu = false
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
        }
    }
    
}

//MARK: - GeneralMenuViewControllerDelegate
extension GeneralViewController: GeneralMenuViewControllerDelegate {
    
    func didSelect(_ menuItem: GeneralMenuViewController.MenuOptions) {
        toggleMenu(completion: nil)
        switch menuItem {
        case .home: break
            //setContextViewController(viewController: vc)
        default: break
        }
    }

}

//MARK: - setContextViewController
extension GeneralViewController {
    private func setContextViewController<T>(viewController: T, removeOtherViewControllers: Bool = false) where T: UIViewController {
        
        guard !contextViewController.children.contains(viewController) else { return }
        
        if removeOtherViewControllers {
            for child in contextViewController.children {
                child.removeChildFromParent()
            }
        }
        
        contextViewController.addChildViewController(viewController)
        viewController.view.frame = contextViewController.view.bounds
        //viewController.view.translatesAutoresizingMaskIntoConstraints = false
        //let margins = contextViewController.view.layoutMarginsGuide
//        NSLayoutConstraint.activate([
//            viewController.view.topAnchor.constraint(equalTo: margins.topAnchor),
//            viewController.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
//            viewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
//            viewController.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
//        ])
    }
}

// MARK: - GeneralPresenterOutput
extension GeneralViewController: GeneralPresenterOutput {
    
}

// MARK: - UIViewController + add/remove childs viewControllers
fileprivate extension UIViewController {
    
    func addChildViewController(_ child: UIViewController) {
        navigationItem.title  = child.navigationItem.title
        navigationItem.prompt = child.navigationItem.prompt
        navigationItem.titleView = child.navigationItem.titleView
        navigationItem.rightBarButtonItems = child.navigationItem.rightBarButtonItems
        
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
