//
//  GeneralCoordinator.swift
//  fmh
//
//  Created: 24.11.2022
//

import Foundation

protocol GeneralCoordinatorProtocol: AnyObject {
    func perfomFlowByMenu(_ menu: SideMenu)
    func perfomDetailScreenFlow(_ screen: GeneralCoordinator.DetailsScreen, type: GeneralCoordinator.PresentType, animated: Bool, completion: (() -> ())?)
}
extension GeneralCoordinatorProtocol {
    func perfomDetailScreenFlow(_ screen: GeneralCoordinator.DetailsScreen, type: GeneralCoordinator.PresentType = .push, animated: Bool = true, completion: (() -> ())? = nil) {
        perfomDetailScreenFlow(screen, type: type, animated: animated, completion: completion)
    }
}


final class GeneralCoordinator: BaseCoordinator {
    
    weak var parentCoordinator: AppCoordinatorProtocol?
    
    private let factory: GeneralScreenFactoryProtocol
    
    var apiClient: APIClientProtocol?
    
    init(router: Routable, factory: GeneralScreenFactoryProtocol) {
        self.factory = factory
        super.init(router: router)
    }
    
    override func start() {
        performSideMenuNavigationControllerFlow()
    }
    
    //TODO: - НАДО ХРАНИТЬ КОНТРОЛЛЕРЫ КАК В ТАБ БАРАХ!?
    private var menuControllers: [(SideMenu, Presentable)] = [ // <- Tuples чтоб передать очередность в меню!
        ( .home, TestVC() ),
        ( .wishes, TestVC() ),
        ( .news, TestVC() ),
        ( .chambers, TestVC() )
    ]
    
    private func performSideMenuNavigationControllerFlow() {
        let naviganionController: SideMenuNavigationControllerProtocol = SideMenuNavigationController(menuControllers: menuControllers)
        naviganionController.isNavigationBarHidden = false
        naviganionController.setUserPofile(apiClient?.userProfile)
        naviganionController.onCompletion = onCompletion
        router.setNavigationController(naviganionController)
    }
    
}

// MARK: GeneralCoordinatorProtocol -
extension GeneralCoordinator: GeneralCoordinatorProtocol {
    
    func perfomFlowByMenu(_ menu: SideMenu) {
        (router.getNavigationController() as? SideMenuNavigationControllerProtocol)?.setViewController(menu: menu)
    }
    
    enum PresentType { case push, present }
    func perfomDetailScreenFlow(_ screen: DetailsScreen, type: PresentType = .push, animated: Bool = true, completion: (() -> ())? = nil) {
        switch type {
        case .push:
            router.push(screen.vc, animated: true)
        case .present:
            router.present(screen.vc, animated: animated, completion: completion)
        }
    }
    
    
    //TODO: или через замыкания регистрировать!
    
    // ... childs screens
    enum DetailsScreen {
        
        case child(model: String) // ??? <- Возможно данные передавать еще ...
        
        var vc: Presentable {
            switch self {
            case .child(let model): return LoadingViewController() // factory
            }
        }
        
    }
    
}


class TestVC: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        title = "TestVC"
    }
    
}
