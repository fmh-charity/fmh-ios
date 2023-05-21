//
//  SideMenuPresenter.swift
//  fmh
//
//  Created: 21.05.2023
//

import Foundation

protocol SideMenuPresenterProtocol {
    func fetchUserInfo(completion: @escaping (SideMenuTopView.Model) -> Void)
}

final class SideMenuPresenter {
    
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
}

// MARK: - SideMenuPresenterProtocol

extension SideMenuPresenter: SideMenuPresenterProtocol {
    
    func fetchUserInfo(completion: @escaping (SideMenuTopView.Model) -> Void) {
        Task(priority: .background) { [weak self] in
            let userInfo = try await self?.apiClient.fetch(with: AuthenticationEndpoint.userInfo, isRetryIfUnauthorized: true)
            guard let userInfo = userInfo else { return }
            
            let title = "\(userInfo.firstName) \(userInfo.lastName)"
            let isAdmin = userInfo.admin ? "Администратор" : ""
            
            let model = SideMenuTopView.Model(title: title, subtitle: isAdmin)
            DispatchQueue.main.async {
                completion(model)
            }
        }
    }
}
