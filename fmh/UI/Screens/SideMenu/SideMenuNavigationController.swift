//
//  SideMenuNavigationController.swift
//  fmh
//
//  Created: 11.12.2022
//

import Foundation
import UIKit

protocol SideMenuNavigationControllerProtocol: BaseNavigationController {
    var coordinator: GeneralCoordinatorProtocol? { get set }
    
    func setUserPofile(_ userProfile: APIClient.UserProfile?)
    func setRootViewController(viewController: UIViewController, menu: SideMenuItems)
}


final class SideMenuNavigationController: BaseNavigationController {
    
    weak var coordinator: GeneralCoordinatorProtocol?
    
    private lazy var sideMenuController: SideMenuViewController = {
        let sideMenuController = SideMenuViewController()
        sideMenuController.view.translatesAutoresizingMaskIntoConstraints = false
        sideMenuController.delegate = self
        sideMenuController.isHighlightedCellOff = false
        return sideMenuController
    }()
    
    private var sideMenuRevealWidth: CGFloat = UIScreen.main.bounds.width * 0.7
    private var sideMenuTrailingConstraint: NSLayoutConstraint?
    private var isSideMenuExpanded: Bool = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override init() {
        super.init()
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sideMenuController.defaultHighlightedMenu = .home
    }
    
    private func configure() {
        view.backgroundColor = .clear // <- Возможно глывный бекгроунд ?!
        configureLayuotSideMenuController()
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
            UIView.animate(withDuration: 0.4) { [unowned self] in
                view.insertSubview(self.shadowView, belowSubview: self.sideMenuController.view)
                self.shadowView.alpha = 0.5
            }
        } else {
            animateSideMenu(false)
            // Animate Shadow (Fade Out)
            UIView.animate(withDuration: 0.4) {
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
    private func setViewController(viewController: UIViewController, animated: Bool = false) {
        setViewControllers([viewController], animated: animated) //TODO: <- Нужна кастомная анимация появления, а не выезд !
        
        // All child views add menu button!
        let menuBtn = UIBarButtonItem(type: .menu, target: self, action: #selector(revealSideMenu))
        viewController.navigationItem.leftBarButtonItem = menuBtn
    }
    
    @objc private func revealSideMenu() {
        setSideMenuState(isShow: !isSideMenuExpanded)
    }
    
}


//MARK: - SideMenuNavigationControllerProtocol
extension SideMenuNavigationController: SideMenuNavigationControllerProtocol {
    
    func setUserPofile(_ userProfile: APIClient.UserProfile?) {
        sideMenuController.profileUser = userProfile
    }
    
    func setRootViewController(viewController: UIViewController, menu: SideMenuItems) {
        sideMenuController.defaultHighlightedMenu = menu
        self.setViewController(viewController: viewController)
    }
    
}


//MARK: - SideMenuViewControllerDelegate
extension SideMenuNavigationController: SideMenuViewControllerDelegate {
    
    func didSelect(itemMenu: SideMenuItems) {
        
        if itemMenu == .logout { logout(); return } //<- Не сворачивая меню
        
        setSideMenuState(isShow: false)
        coordinator?.perfomFlowByMenu(itemMenu)
    }
    
    private func logout() {
        
        //TODO: ЗАПИЛИТЬ КАСТОМНЫЙ ПОПАП !!!
        
        let message = "Вы действительно хотите выйти!"
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Выйти", style: .cancel) {[weak self] _ in self?.onCompletion?() })
        alert.addAction(UIAlertAction(title: "Закрыть", style: .default))
        self.present(alert, animated: true, completion: nil)
        
    }
    
}
