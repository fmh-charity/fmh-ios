//
//  GeneralViewController.swift
//  fmh
//
//  Created: 25.05.2022
//
//  https://github.com/johncodeos-blog/CustomSideMenuiOSExample/tree/main/CustomSideMenuiOSExample

import UIKit

class GeneralViewController: UIViewController, GeneralViewControllerProtocol {
    
    var onCompletion: (() -> ())?
    
    var presenter: GeneralPresenterInput?
    
    /// GeneralViewControllerProtocol
    weak var contextViewController: UIViewController?
    var didSelectMenu: ((_ menuOptions: GeneralMenu) -> ())?
    var didSelectAdditionalMenu: ((_ menuOptions: GeneralMenu.AdditionalMenu) -> ())?

    private var sideMenuRevealWidth: CGFloat = 260
    private var isExpanded: Bool = false
    private var sideMenuTrailingConstraint: NSLayoutConstraint!
    
    private var sideMenuViewController: SideMenuViewController = {
        let viewController = SideMenuViewController()

        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        return viewController
    }()
    
    private var userInfo: UserInfo? = nil {
        didSet {
            guard let f = userInfo?.lastName,
                  let i = userInfo?.firstName.first?.uppercased(),
                  let o = userInfo?.middleName.first?.uppercased() else { return }
            sideMenuViewController.shortUserName = f + " " + i + "." + o + "."
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground

        showSideMenuView()
        
        presenter?.getUserInfo(completion: { [weak self] userInfo, error in
            if let _ = error {
                self?.onCompletion?()
            }
            if let userInfo = userInfo {
                DispatchQueue.main.async { self?.userInfo = userInfo }
            }
        })

        /// Default  View Controller
        if let navigationViewController = contextViewController as? UINavigationController, !navigationViewController.viewControllers.isEmpty {
            showViewController(viewController: navigationViewController)
        } else {
            // TODO: Экран заглушка нужен, если всетаки прилетел не контроллер
            print("Необходимо в GeneralCoordinator установить viewController в navigationController.viewControllers = [?]")
            self.onCompletion?()
        }
    
    }

}

// MARK: - Private methods class
extension GeneralViewController {
    
    private func showSideMenuView() {
        self.sideMenuViewController.defaultHighlightedCell = 0
        self.sideMenuViewController.delegate = self
        view.insertSubview(self.sideMenuViewController.view, at: 2)
        addChild(self.sideMenuViewController)
        self.sideMenuViewController.didMove(toParent: self)

        NSLayoutConstraint.activate([
            self.sideMenuViewController.view.widthAnchor.constraint(equalToConstant: self.sideMenuRevealWidth),
            self.sideMenuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.sideMenuViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
        ])
        self.sideMenuTrailingConstraint = self.sideMenuViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -self.sideMenuRevealWidth)
        self.sideMenuTrailingConstraint.isActive = true
    }
    
    private func sideMenuState(expanded: Bool) {
        if expanded {
            let shadowView = makeShadowView()
            shadowView.tag = 100
            self.animateSideMenu(targetPosition: 0) { _ in
                self.isExpanded = true
            }
            UIView.animate(withDuration: 0.5) { [unowned self] in
                shadowView.alpha = 0.6
                self.view.insertSubview(shadowView, at: 1)
            }
        }
        else {
            let shadowView = self.view.viewWithTag(100)
            self.animateSideMenu(targetPosition: -self.sideMenuRevealWidth) { _ in
                self.isExpanded = false
            }
            UIView.animate(withDuration: 0.5) {
                shadowView?.alpha = 0.0
            } completion: { _ in
                shadowView?.removeFromSuperview()
            }
        }
    }
    
    private func animateSideMenu(targetPosition: CGFloat, completion: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .layoutSubviews, animations: {
            self.sideMenuTrailingConstraint.constant = targetPosition
            self.view.layoutIfNeeded()
        }, completion: completion)
    }
    
    private func makeShadowView() -> UIView {
        let view = UIView(frame: self.view.bounds)
        view.backgroundColor = .black
        view.alpha = 0.0
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapShadowView))
        tapGestureRecognizer.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGestureRecognizer)
        
        return view
    }
    
    private func showViewController<T: UIViewController>(viewController: T) -> () {
        // Remove the previous View
        for subview in view.subviews {
            if subview.tag == 99 {
                subview.removeFromSuperview()
            }
        }
        
        viewController.view.tag = 99
        view.insertSubview(viewController.view, at: 0)
        addChild(viewController)
        viewController.view.frame = self.view.bounds
        viewController.didMove(toParent: self)
    }
    
}

// MARK: - @objcs actions
extension GeneralViewController {
    
    ///  Show menu in other (chlds) viewControllers
    @objc open func revealSideMenu() {
        self.sideMenuState(expanded: self.isExpanded ? false : true)
    }
    
    @objc open func tapOurMissionButton() {
        self.didSelectMenu?(.ourMission)
    }
    
    @objc open func tapUserButton() {
        self.didSelectAdditionalMenu?(.user)
    }
    
    @objc func tapShadowView(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if self.isExpanded {
                self.sideMenuState(expanded: false)
            }
        }
    }
    
}

// MARK: - GeneralPresenterOutput
extension GeneralViewController: GeneralPresenterOutput {

}

//MARK: - SideMenuViewControllerDelegate
extension GeneralViewController: SideMenuViewControllerDelegate {
    
    func didSelect(indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            let itemMenu = GeneralMenu.allCases[indexPath.row]
            self.didSelectMenu?(itemMenu)
        }
        
        if indexPath.section == 1 {
            let itemMenu = GeneralMenu.AdditionalMenu.allCases[indexPath.row]
            self.didSelectAdditionalMenu?(itemMenu)
        }

        DispatchQueue.main.async { self.sideMenuState(expanded: false) }
    }

}
