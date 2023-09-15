
import UIKit

class MenuViewController: UIViewController {
    
    private var isMenuExpanded: Bool = false {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    private let menuRevealWidth: CGFloat = UIScreen.main.bounds.width * 0.75
    private var draggingIsEnabled: Bool = false
    
    // Dependencies
    private let presenter: MenuViewPresenterProtocol
    private let sideMenuViewController: SideMenuViewControllerProtocol
    private let containerViewController: UIViewController
    
    // MARK: - UI
    
    private lazy var sideMenuViewControllerRightAnchor = sideMenuViewController.view.rightAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
    
    private lazy var shadowView: UIView = {
        let view = UIView(frame: .init(x: 1, y: 0, width: view.bounds.width - 1, height: view.bounds.height))
        view.backgroundColor = .black
        view.alpha = 0.0
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(revealMenu))
        tapGestureRecognizer.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGestureRecognizer)
        return view
    }()
    
    // MARK: - Life cycle
    
    init(
        presenter: MenuViewPresenterProtocol,
        sideMenuViewController: SideMenuViewControllerProtocol,
        containerViewController: UIViewController
    ) {
        self.presenter = presenter
        self.sideMenuViewController = sideMenuViewController
        self.containerViewController = containerViewController
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayoutContainerController()
        configureLayoutSideMenuViewController()
        setDataSideMenuViewController()
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGestureRecognizer.delegate = self
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    // StatusBarHidden
    
    override var childForStatusBarHidden: UIViewController? {
        isMenuExpanded ? nil : containerViewController
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
        isChildForStatusBarStyle ? containerViewController : nil
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    // MARK: - Setup UI
    
    private func configureLayoutContainerController() {
        addChild(containerViewController)
        view.insertSubview(containerViewController.view, aboveSubview: view)
        containerViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            containerViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureLayoutSideMenuViewController() {
        addChild(sideMenuViewController)
        view.insertSubview(sideMenuViewController.view, aboveSubview: view)
        sideMenuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sideMenuViewController.view.widthAnchor.constraint(equalToConstant: menuRevealWidth),
            sideMenuViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            sideMenuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        sideMenuViewControllerRightAnchor.isActive = true
    }
    
    // MARK: - Private
    
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
            
            guard let self else { return }
            
            self.isMenuExpanded = isShow
            
            self.shadowView.alpha = isShow ? 0.3 : 0.0
            if isShow {
                self.containerViewController.view.insertSubview(self.shadowView, belowSubview: self.containerViewController.view)
            }
            
            self.containerViewController.view.frame.origin.x = isShow ? self.menuRevealWidth / 2 : 0
            self.sideMenuViewControllerRightAnchor.constant = isShow ? self.menuRevealWidth : 0
            self.view.layoutIfNeeded()
            
        }, completion: { isFinished in
            completion?(isFinished)
        })
    }
    
    private func setDataSideMenuViewController() {
        presenter.fetchUserInfo { [weak self] model, _ in
            if let model {
                self?.sideMenuViewController.setTopViewModel(model)
            }
        }
    }
    
    // MARK: - Actions
    
    @objc private func revealMenu() {
        setSideMenuState(isShow: !isMenuExpanded)
    }
}

// MARK: - UIGestureRecognizerDelegate

extension MenuViewController: UIGestureRecognizerDelegate {
    
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
                containerViewController.view.insertSubview(self.shadowView, belowSubview: containerViewController.view)
            } else if velocity < 0, self.isMenuExpanded {
                self.draggingIsEnabled = true
            }
            
        case .changed:
            
            if self.draggingIsEnabled {
                
                let percentage = (containerViewController.view.frame.origin.x * 200 / self.menuRevealWidth) / self.menuRevealWidth
                
                let alpha = percentage >= 0.3 ? 0.3 : percentage
                self.shadowView.alpha = alpha
                
                if containerViewController.view.frame.origin.x <= self.menuRevealWidth,
                   containerViewController.view.frame.origin.x >= 0
                {
                    let menuX = max(min(self.sideMenuViewControllerRightAnchor.constant + position, menuRevealWidth), 0)
                    let contentX = max(min(containerViewController.view.frame.origin.x + position / 2, menuRevealWidth / 2), 0)
                    containerViewController.view.frame.origin.x = contentX
                    self.sideMenuViewControllerRightAnchor.constant = menuX
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
            let movedMoreThanHalf = self.sideMenuViewControllerRightAnchor.constant > self.menuRevealWidth * 0.5
            self.setSideMenuState(isShow: movedMoreThanHalf)
            
        default:
            break
        }
    }
}

// MARK: - TabBarViewControllerDelegate

extension MenuViewController: TabBarViewControllerDelegate {
    
    func toggleMenu() {
        revealMenu()
    }
}
