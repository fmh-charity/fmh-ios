//
//  UIModuleFactoryProtocol.swift
//  fmh
//
//  Created: 14.05.2022
//

import Foundation

// MARK: Это протоколы основных экранов (которые в меню) ... -

// MARK:  UIModuleFactoryAutorizationProtocol
protocol UIModuleFactoryAutorizationProtocol {
    func makeUIModuleAutorizationViewController() -> FMHUIViewControllerBaseProtocol
}


// MARK:  UIModuleFactoryLoadingProtocol
protocol UIModuleFactoryLoadingProtocol {
    func makeLoadingViewController() -> FMHUIViewControllerBaseProtocol
}


// MARK:  UIModuleFactoryGeneralProtocol
protocol UIModuleFactoryGeneralProtocol: UIModuleFactoryNewsRouting, UIModuleFactoryWishesRouting {
    func makeUIModuleOurMissionViewController() -> FMHUIViewControllerBaseProtocol
    func makeUIModuleNewsViewController(router: UICoordinatorGeneralTransitions) -> FMHUIViewControllerBaseProtocol
    func makeUIModulePatientsViewController() -> FMHUIViewControllerBaseProtocol
    func makeUIModuleWishesViewController(router: UICoordinatorGeneralTransitions) -> FMHUIViewControllerBaseProtocol
    func makeUIModuleClaimsViewController() -> FMHUIViewControllerBaseProtocol
}



// MARK: Это протоколы переходов для дочерних экранов ... -


// MARK: - UIModuleFactoryAdmissionsRouting
protocol UIModuleFactoryAdmissionsRouting {
    // ...
}

// MARK: - UIModuleFactoryClaimsRouting
protocol UIModuleFactoryClaimsRouting {
    // ...
}

// MARK: - UIModuleFactoryNewsRouting
protocol UIModuleFactoryNewsRouting {
    func makeUIModuleNewsChildViewController() -> FMHUIViewControllerBaseProtocol
    func makeUIModuleNewsDetailsViewController(router: UICoordinatorGeneralTransitions) -> FMHUIViewControllerBaseProtocol
    func makeUIModuleFilterNewsViewController() -> FMHUIViewControllerBaseProtocol
    func makeUIModuleAddNewsViewController() -> FMHUIViewControllerBaseProtocol
    // ...
}

// MARK: - UIModuleFactoryNurseStationRouting
protocol UIModuleFactoryNurseStationRouting {
    // ...
}

// MARK: - UIModuleFactoryPatientsRouting
protocol UIModuleFactoryPatientsRouting {
    // ...
}

// MARK: - UIModuleFactoryUsersRouting
protocol UIModuleFactoryUsersRouting {
    // ...
}

// MARK: - UIModuleFactoryWishesRouting
protocol UIModuleFactoryWishesRouting {
    func makeUIModuleWishDetailViewConstroller() -> FMHUIViewControllerBaseProtocol
    // ...
}
