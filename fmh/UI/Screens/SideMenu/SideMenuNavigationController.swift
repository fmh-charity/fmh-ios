//
//  SideMenuNavigationController.swift
//  fmh
//
//  Created: 11.12.2022
//

import Foundation
import UIKit


class SideMenuNavigationController: BaseNavigationController {
    
    //    weak var coordinator: GeneralCoordinatorProtocol?
    
    //TODO: - НАДО ХРАНИТЬ КОНТРОЛЛЕРЫ КАК В ТАБАХ? (не перезагружая каждый раз)
    private var menuViewControllers: [SideMenu : BaseViewControllerProtocol]
    
    var userProfile: APIClient.UserProfile? {
        didSet {
            if let profile = userProfile {
                let f: String = profile.lastName
                let i = String(profile.firstName.first ?? " ")
                let o = String(profile.middleName.first ?? " ")
                sideMenuController.shortUserName = "\(f) \(i).\(o)."
            }
        }
    }
    
    let sideMenuController: SideMenuViewController = {
        let sideMenuController = SideMenuViewController()
        sideMenuController.view.translatesAutoresizingMaskIntoConstraints = false
        return sideMenuController
    }()
    
    private var sideMenuRevealWidth: CGFloat = UIScreen.main.bounds.width * 0.7
    private var sideMenuTrailingConstraint: NSLayoutConstraint?
    private var isSideMenuExpanded: Bool = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    init(menuViewControllers: [SideMenu : BaseViewControllerProtocol]) {
        self.menuViewControllers = menuViewControllers
        super.init()
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        view.backgroundColor = .clear // <- Возможно глывный бекгроунд ?!
        configureLayuotSideMenuController()
        
        let testVC = UIViewController()
        testVC.view.backgroundColor = .orange
        
        setViewController(testVC)
        
    }
    
    
    //MARK: - StatusBarStyle
    override var childForStatusBarHidden: UIViewController? {
        isSideMenuExpanded ? nil : topViewController
    }
    
    override var prefersStatusBarHidden: Bool {
        true
    }
    
    /// use child status bar style. def=false
    var isChildForStatusBarStyle: Bool = false {
        didSet{
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    override var childForStatusBarStyle: UIViewController? {
        isChildForStatusBarStyle ? topViewController : nil
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

    
    //MARK: - Configure side menu
    private func configureLayuotSideMenuController() {
        addChild(sideMenuController)
        view.insertSubview(sideMenuController.view, aboveSubview: view)
        sideMenuController.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            sideMenuController.view.widthAnchor.constraint(equalToConstant: sideMenuRevealWidth),
            sideMenuController.view.topAnchor.constraint(equalTo: view.topAnchor),
            sideMenuController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        sideMenuTrailingConstraint = sideMenuController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -sideMenuRevealWidth)
        sideMenuTrailingConstraint?.isActive = true
    }
    
    private lazy var shadowView: UIView = {
        let view = UIView(frame: self.view.bounds)
        view.backgroundColor = .black
        view.alpha = 0.0
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(shadowTap))
        tapGestureRecognizer.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGestureRecognizer)
        return view
    }()
    
    @objc private func shadowTap() {
        setSideMenuState(isShow: false)
    }
    
    private func setSideMenuState(isShow: Bool) {
        if isShow {
            self.isSideMenuExpanded = true
            animateSideMenu(true)
            // Animate Shadow (Fade In)
            UIView.animate(withDuration: 0.5) { [unowned self] in
                view.insertSubview(self.shadowView, belowSubview: self.sideMenuController.view)
                self.shadowView.alpha = 0.5
            }
        } else {
            animateSideMenu(false)
            // Animate Shadow (Fade Out)
            UIView.animate(withDuration: 0.5) {
                self.shadowView.alpha = 0.0
            } completion: { [unowned self] _ in
                self.shadowView.removeFromSuperview()
            }
        }
    }
    
    private func animateSideMenu(_ isShow: Bool, completion: ((Bool) -> ())? = nil) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .layoutSubviews, animations: { [weak self] in
            guard let self = self else { return }
            self.isSideMenuExpanded = isShow
            self.sideMenuTrailingConstraint?.constant = isShow ? 0 : -self.sideMenuRevealWidth
            self.view.layoutIfNeeded()
        }, completion: { finished in
            completion?(finished)
        })
    }
    
    
    //MARK: - Configure child view controllers
    private func setViewController(_ viewController: UIViewController) {
        setViewControllers([viewController], animated: false)
        
        // All child views add menu button!
        let menuBtn = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .done, target: self, action: #selector(revealSideMenu))
        viewController.navigationItem.leftBarButtonItem = menuBtn
    }
    
    @objc private func revealSideMenu() {
        setSideMenuState(isShow: !isSideMenuExpanded)
    }
    
}

