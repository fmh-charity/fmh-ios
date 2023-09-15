
import UIKit

protocol TabBarViewControllerDelegate: AnyObject {
    func toggleMenu()
}

class TabBarController: UITabBarController {
    
    // MARK: - UI
    
    private lazy var menuButton: UIBarButtonItem = {
        let image = UIImage(systemName: "line.3.horizontal")
        let item = UIBarButtonItem(image: image, style: .done, target: self, action: #selector(toggleMenu))
        return item
    }()
    
    // Dependencies
    weak var handlerActionsMenu: TabBarViewControllerDelegate?
    
    // MARK: - Life cycle
    
    init(
        viewControllers: [UIViewController]
    ) {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemBackground
        setViewControllers(viewControllers, animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Actions
    
    @objc private func toggleMenu() {
        handlerActionsMenu?.toggleMenu()
    }
}

// MARK: - Set view controllers

extension TabBarController {
    
    override func setViewControllers(_ viewControllers: [UIViewController]?, animated: Bool) {
        viewControllers?.forEach {
            if let viewController = ($0 as? UINavigationController)?.viewControllers.first {
                viewController.navigationItem.leftBarButtonItem = menuButton
            }
        }
        super.setViewControllers(viewControllers, animated: animated)
    }
}
