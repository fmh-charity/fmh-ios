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
    weak var contextNavigationController: UINavigationController?
    
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
            guard let context = self.contextNavigationController else { return }
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut) {
                context.view.frame.origin.x = context.view.frame.size.width - 100
                //TODO: Добавить обработчик нажатия и притемнять
                context.view.layer.shadowColor = UIColor.white.cgColor
                context.view.layer.shadowOffset = CGSize(width: 0.0, height: -2.0)
                context.view.layer.shadowRadius = 5.0
                context.view.layer.shadowOpacity = 0.3
                context.view.layer.masksToBounds = false
            } completion: { [unowned self] done in
                if done {
                    self.isActiveMenu = true
                }
            }
        case true:
            /// close
            guard let context = self.contextNavigationController else { return }
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut) {
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
    func didSelect(indexPath: IndexPath) {
        if indexPath.section == 0 {
            let itemMenu = GeneralMenuViewController.MenuOptions.allCases[indexPath.row]
            switch itemMenu {
            case .home: break
                //setContextViewController(viewController: vc)
            default: break
            }
        }
        if indexPath.section == 1 {
            let itemMenu = GeneralMenuViewController.AdditionalMenuOptions.allCases[indexPath.row]
            switch itemMenu {
            case .settings: break
            case .logOut: break //presenter?.logOut()
            }
        }
        toggleMenu(completion: nil)
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
