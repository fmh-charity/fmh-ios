//
//  SideMenuController.swift
//  fmh
//
//  Created: 08.05.2023
//

import UIKit

protocol SideMenuControllerProtocol: ViewController {
    var coordinator: GeneralCoordinatorProtocol? { get set }
    var contentController: UINavigationController { get }
    
    func setUserProfile(_ userProfile: APIClient.UserProfile?)
    func setRootViewController(viewController: UIViewController, menu: SideMenuItems)
}

final class SideMenuController: ViewController, SideMenuControllerProtocol {

    weak var coordinator: GeneralCoordinatorProtocol?
    
    let contentController: UINavigationController
    
    private var menuRevealWidth: CGFloat = UIScreen.main.bounds.width * 0.75
    private var draggingIsEnabled: Bool = false
    
    private var isMenuExpanded: Bool = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    // MARK: - UI
    
    private lazy var menuControllerRightAnchor = menuController.view.rightAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
    
    private lazy var menuController: SideMenuViewController = {
        let sideMenuController = SideMenuViewController()
        sideMenuController.delegate = self
        sideMenuController.isHighlightedCellOff = false
        return sideMenuController
    }()
    
    private lazy var shadowView: UIView = {
        let view = UIView(frame: .init(x: 1, y: 0, width: view.bounds.width - 1, height: view.bounds.height))
        view.backgroundColor = .black
        view.alpha = 0.0
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(revealMenu))
        tapGestureRecognizer.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGestureRecognizer)
        return view
    }()
    
    // MARK: - LifeCycle
    
    init(contentController: UINavigationController) {
        self.contentController = contentController
        super.init()
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // StatusBarHidden
    
    override var childForStatusBarHidden: UIViewController? {
        isMenuExpanded ? nil : contentController.topViewController
    }
    
    override var prefersStatusBarHidden: Bool {
        true
    }
    
    // StatusBarStyle
    
    var isChildForStatusBarStyle: Bool = false {
        didSet{
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    override var childForStatusBarStyle: UIViewController? {
        isChildForStatusBarStyle ? contentController.topViewController : nil
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    // CommonInit
    
    private func commonInit() {
        
        // Кто первый тот поверх кажется.
        configureLayoutContentController()
        configureLayoutMenuController()
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGestureRecognizer.delegate = self
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    // MARK: - Setup UI
    
    private func configureLayoutMenuController() {
        addChild(menuController)
        view.insertSubview(menuController.view, aboveSubview: view)
        menuController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuController.view.widthAnchor.constraint(equalToConstant: menuRevealWidth),
            menuController.view.topAnchor.constraint(equalTo: view.topAnchor),
            menuController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        menuControllerRightAnchor.isActive = true
    }
    
    private func configureLayoutContentController() {
        addChild(contentController)
        contentController.view.backgroundColor = .systemBackground
        view.insertSubview(contentController.view, aboveSubview: view)
        contentController.didMove(toParent: self)
    }
    
    // MARK: - Private methods, Animate sideMenu

    private func setSideMenuState(isShow: Bool) {
        if isShow {
            self.isMenuExpanded = true
            animateSideMenu(true)
        } else {
            animateSideMenu(false) { [weak self] _ in
                self?.shadowView.removeFromSuperview()
            }
        }
    }
    
    private func animateSideMenu(_ isShow: Bool, completion: ((Bool) -> ())? = nil) {
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .layoutSubviews, animations: { [weak self] in
            guard let self = self else { return }

            self.isMenuExpanded = isShow

            self.shadowView.alpha = isShow ? 0.3 : 0.0
            if isShow {
                self.contentController.view.insertSubview(self.shadowView, belowSubview: self.contentController.view)
            }
            
            self.contentController.view.frame.origin.x = isShow ? self.menuRevealWidth / 2 : 0
            self.menuControllerRightAnchor.constant = isShow ? self.menuRevealWidth : 0
            self.view.layoutIfNeeded()
            
        }, completion: { isFinished in
            completion?(isFinished)
        })
    }

    // MARK: - Actions
    
    @objc private func revealMenu() {
        setSideMenuState(isShow: !isMenuExpanded)
    }
    
    // MARK: - Private logics
    
    private func setViewController(viewController: UIViewController, animated: Bool = false) {
        contentController.setViewControllers([viewController], animated: animated)
        let menuButton = UIBarButtonItem(type: .menu, target: self, action: #selector(revealMenu))
        viewController.navigationItem.leftBarButtonItem = menuButton
    }
    
    // MARK: - SideMenuControllerProtocol
    
    func setUserProfile(_ userProfile: APIClient.UserProfile?) {
        menuController.profileUser = userProfile
    }
    
    func setRootViewController(viewController: UIViewController, menu: SideMenuItems) {
        menuController.defaultHighlightedMenu = menu
        self.setViewController(viewController: viewController)
    }
}

// MARK: - SideMenuViewControllerDelegate

extension SideMenuController: SideMenuViewControllerDelegate {
    
    func didSelect(itemMenu: SideMenuItems) {
        if itemMenu == .logout { logout(); return }
        
        setSideMenuState(isShow: false)
        coordinator?.performFlow(with: itemMenu)
    }
    
    private func logout() {
        let message = "Вы действительно хотите выйти!"
        self.showAlertWithAction(message: message, actionTitle: "Выйти") { [weak self] _ in
            self?.onCompletion?()
        }
    }
}


// MARK: - UIGestureRecognizerDelegate

extension SideMenuController: UIGestureRecognizerDelegate {
    
    @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
        
        let position: CGFloat = sender.translation(in: self.view).x
        let velocity: CGFloat = sender.velocity(in: self.view).x
        
        switch sender.state {
        case .began:

            if (velocity > 0 && self.isMenuExpanded) || (velocity < 0 && !self.isMenuExpanded) {
                sender.state = .cancelled
            }
            
            if velocity > 0, !self.isMenuExpanded {
                self.draggingIsEnabled = true
                contentController.view.insertSubview(self.shadowView, belowSubview: contentController.view)
            } else if velocity < 0, self.isMenuExpanded {
                self.draggingIsEnabled = true
            }

        case .changed:
            
            if self.draggingIsEnabled {

                let percentage = (contentController.view.frame.origin.x * 200 / self.menuRevealWidth) / self.menuRevealWidth
                
                let alpha = percentage >= 0.3 ? 0.3 : percentage
                self.shadowView.alpha = alpha

                if contentController.view.frame.origin.x <= self.menuRevealWidth,
                   contentController.view.frame.origin.x >= 0
                {
                    let menuX = max(min(self.menuControllerRightAnchor.constant + position, menuRevealWidth), 0)
                    let contentX = max(min(contentController.view.frame.origin.x + position / 2, menuRevealWidth / 2), 0)
                    contentController.view.frame.origin.x = contentX
                    self.menuControllerRightAnchor.constant = menuX
                    sender.setTranslation(CGPoint.zero, in: view)
                }
            }
            
        case .ended:
            
            let velocityThreshold: CGFloat = 300
            if abs(velocity) > velocityThreshold {
                self.setSideMenuState(isShow: self.isMenuExpanded ? false : true)
                self.draggingIsEnabled = false
                return
            }
            
            self.draggingIsEnabled = false
            let movedMoreThanHalf = self.menuControllerRightAnchor.constant > self.menuRevealWidth * 0.5
            self.setSideMenuState(isShow: movedMoreThanHalf)
            
        default:
            break
        }
    }
}
