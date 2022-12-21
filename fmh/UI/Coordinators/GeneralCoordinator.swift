//
//  GeneralCoordinator.swift
//  fmh
//
//  Created: 24.11.2022
//

import Foundation

protocol GeneralCoordinatorProtocol: AnyObject {
    /// Переход для экранов в SideMenu
    func perfomFlowByMenu(_ menu: SideMenuItems)
    /// Переход для всех экранов Screens
    func perfomScreenFlow(_ screen: GeneralCoordinator.Screens, type: GeneralCoordinator.PresentType, animated: Bool, completion: (() -> ())?)

}
extension GeneralCoordinatorProtocol {
    /// Переход для всех экранов Screens
    func perfomScreenFlow(_ screen: GeneralCoordinator.Screens, type: GeneralCoordinator.PresentType = .push, animated: Bool = true, completion: (() -> ())? = nil) {
        perfomScreenFlow(screen, type: type, animated: animated, completion: completion)
    }
}


final class GeneralCoordinator: BaseCoordinator {
    
    weak var parentCoordinator: AppCoordinatorProtocol?
    
    let factory: GeneralScreenFactoryProtocol
    
    var apiClient: APIClientProtocol?
    
    init(router: Routable, factory: GeneralScreenFactoryProtocol) {
        self.factory = factory
        super.init(router: router)
    }
    
    override func start() {
        performSideMenuNavigationControllerFlow()
        perfomFlowByMenu(.home) //<- По умолчанию
    }
    
    //TODO: - ХРАНИМЫЕ КОНТРОЛЛЕРЫ КАК В ТАБ БАРАХ!?
    private lazy var menuControllers: [SideMenuItems : Presentable] = {
        [
            .home     : TestVC() ,
        ]
    }()
    
    private func performSideMenuNavigationControllerFlow() {
        let naviganionController: SideMenuNavigationControllerProtocol = SideMenuNavigationController()
        naviganionController.isNavigationBarHidden = false
        naviganionController.coordinator = self
        naviganionController.setUserPofile(apiClient?.userProfile)
        naviganionController.onCompletion = onCompletion
        router.setNavigationController(naviganionController)
    }
    
}

// MARK: GeneralCoordinatorProtocol -
extension GeneralCoordinator: GeneralCoordinatorProtocol {
    
    /// Переход для экранов в SideMenu
    func perfomFlowByMenu(_ menu: SideMenuItems) {
        
        let menuNavController = (router.getNavigationController() as? SideMenuNavigationControllerProtocol)
        guard let menuNavController = menuNavController else { return }
        
        // Если контроллер хранится.
        if let vc = menuControllers[menu] {
            menuNavController.setRootViewController(viewController: vc.toPresent, menu: menu)
            return
        }
        
        // Если не хранится, перебираем и отображаем.
        switch menu {
        case .documents:
            let controller = TestVC2()
            menuNavController.setRootViewController(viewController: controller, menu: menu)
            
            // ... тут добавляем менюшные экраны + кликабельные элементы (SideMenuItems)
            
        case .profile: perfomScreenFlow(.profile, type: .present)
        
        case .ourMission:
            let controller = factory.makeOurMissionViewController()
            menuNavController.setRootViewController(viewController: controller, menu: menu)
            
        default: break
        }
        
    }

    enum PresentType { case push, present }
    /// Переход для всех экранов Screens
    func perfomScreenFlow(_ screenType: Screens, type: PresentType = .push, animated: Bool = true, completion: (() -> ())? = nil) {
        
        var screen: Presentable?
        
        switch screenType {
        case .profile: screen = factory.makeProfileViewController()
        case .ourMission: screen = factory.makeOurMissionViewController()
            
            // ... тут добавляем дочернии экраны
            
        default: break
        }
        
        switch type {
        case .push: router.push(screen, animated: true)
        case .present: router.present(screen, animated: animated, completion: completion)
        }
    }
    
    // Экраны которые не храним в "menuControllers". (каждый раз создаются)
    enum Screens {
        case child(model: String) // ??? <- Возможно данные передавать еще ...
        
        case profile
        case ourMission
    }
    
}



class TestVC: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        title = "TestVC"
    }
    
}

class TestVC2: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        title = "TestVC"
    }
    
}
