//
//  GeneralCoordinator.swift
//  fmh
//
//  Created: 24.11.2022
//

import Foundation

protocol GeneralCoordinatorProtocol: AnyObject {
    func performFlow(with menu: SideMenuItems)
    func performFlow(with screen: GeneralCoordinator.Screens, type: GeneralCoordinator.PresentType, animated: Bool, completion: (() -> ())?)
}

extension GeneralCoordinatorProtocol {
    func performFlow(with screen: GeneralCoordinator.Screens, type: GeneralCoordinator.PresentType = .push, animated: Bool = true, completion: (() -> ())? = nil) {
        performFlow(with: screen, type: type, animated: animated, completion: completion)
    }
}

// MARK: - GeneralCoordinator

final class GeneralCoordinator: Coordinator {
    
    weak var parentCoordinator: AppCoordinatorProtocol?
    
    let factory: GeneralScreenFactoryProtocol
    
    var apiClient: APIClientProtocol?
    
    init(router: Routable, factory: GeneralScreenFactoryProtocol) {
        self.factory = factory
        super.init(router: router)
    }
    
    override func start() {
        performSideMenuControllerFlow()
        performFlow(with: .home) //<- По умолчанию
    }
    
    // TODO: - ХРАНИМЫЕ КОНТРОЛЛЕРЫ !!!
    
    private lazy var menuControllers: [SideMenuItems : Presentable] = {
        [
            .home     : TestVC() ,
        ]
    }()
    
    private func performSideMenuControllerFlow() {
        let sideMenuController: SideMenuControllerProtocol = factory.makeSideMenuController()
        sideMenuController.coordinator = self
        sideMenuController.onCompletion = onCompletion
        router.setWindowRoot(sideMenuController)
        router.setNavigationController(sideMenuController.contentController)
    }
}

// MARK: - GeneralCoordinatorProtocol

extension GeneralCoordinator: GeneralCoordinatorProtocol {
    
    func performFlow(with menu: SideMenuItems) {
        
        let menuController = (router.getRootViewController() as? SideMenuControllerProtocol)
        guard let menuController = menuController else { return }
        
        if let vc = menuControllers[menu] {
            menuController.setRootViewController(viewController: vc.toPresent, menu: menu)
            return
        }
        
        switch menu {
        case .documents:
            let controller = TestVC2()
            menuController.setRootViewController(viewController: controller, menu: menu)
            
        case .profile:
            performFlow(with: .profile, type: .present)
            
        case .ourMission:
            performFlow(with: .ourMission, type: .root)
            
            // ...
            
            //рассмотреть все варианты переходов: меню, элементы меню (без выделения???!!!), и дочерние экраны
            
            //РАССМОТРЕТЬ ВОЗМОЖНОСТЬ ДОБАВЛЯТЬ КООРДИНАТОР/РОУТЕР ДЛЯ КАЖДОГО ЭКРАНА ??? НАПР -НОВОСТИ-
            
        default: break
        }
    }
    
    enum PresentType { case push, present, root }
    
    func performFlow(with screenType: Screens, type: PresentType = .push, animated: Bool = true, completion: (() -> ())? = nil) {
        
        let screen = screenType.makeController(factory: factory)
        
        switch type {
        case .push: router.push(screen, animated: true)
        case .present: router.present(screen, animated: animated, completion: completion)
        case .root:
            let menuController = (router.getRootViewController() as? SideMenuControllerProtocol)
            if let viewController = screen?.toPresent, let menuController {
                menuController.setRootViewController(viewController: viewController, menu: .none)
            }
        }
    }
}

// MARK: - Screens

extension GeneralCoordinator {
    
    enum Screens {
        case child([String:Any]) // ??? <- Возможно данные передавать еще ...
        
        case profile, ourMission
        
        func makeController(factory: GeneralScreenFactoryProtocol) -> Presentable? {
            switch self {
            case .profile:      return factory.makeProfileViewController()
            case .ourMission:   return factory.makeOurMissionViewController()
                
                // ...
                
            default:            return nil
            }
        }
    }
}

class TestVC: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        title = "TestVC"
    }
}

class TestVC2: ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        title = "TestVC"
    }
}
