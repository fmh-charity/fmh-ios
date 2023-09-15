
import UIKit
import Networking

protocol MorePresenterProtocol {
    func setDelegate(_ delegate: MorePresenterDelegate)
}

protocol MorePresenterDelegate: AnyObject {
    func insertCardView(_ view: UIView, at stackIndex: Int)
    func addArrangedSubview(_ view: UIView)
}

final class MorePresenter {
    
    // Dependencies
    private let networkService: NetworkProtocol
    weak var delegate: MorePresenterDelegate?
    
    init(
        networkService: NetworkProtocol
    ) {
        self.networkService = networkService
    }
}

// MARK: - MorePresenterProtocol

extension MorePresenter: MorePresenterProtocol {
    
    func setDelegate(_ delegate: MorePresenterDelegate) {
        self.delegate = delegate
        fetchUserInfo()
        assemblyCards()
    }
}

// MARK: - Data

private extension MorePresenter {
    
    func assemblyCards() {
        // TODO: Добавить нажатия + вынести в зависимость!
        delegate?.addArrangedSubview(SimpleCardView(imageName: "icon.mission", title: "Миссия"))
        delegate?.addArrangedSubview(SimpleCardView(imageName: "icon.about", title: "О хосписе"))
        delegate?.addArrangedSubview(SimpleCardView(imageName: "icon.mission", title: "О приложении"))
        delegate?.addArrangedSubview(SimpleCardView(imageName: "gear", title: "Настройки"))
    }
}

// MARK: - Networking

private extension MorePresenter {
    
    func fetchUserInfo() {
        Task {
            let userInfoEndpoint = UserInfoEndpoint()
            let rolesEndpoint = RolesEndpoint()
            do {
                let responseUserInfo = try await networkService.perform(for: userInfoEndpoint)
                let responseRoles = try await networkService.perform(for: rolesEndpoint)
                let userInfo: UserInfo = try JSONDecoder().decode(UserInfo.self, from: responseUserInfo.0)
                let roles: [Roles] = try JSONDecoder().decode([Roles].self, from: responseRoles.0)
                
                var rolesInfo: [String] = []
                userInfo.roles?.forEach { userRole in
                    if
                        let _role = roles.first(where: { $0.name == userRole }),
                        let roleDescription = _role.description
                    {
                        rolesInfo.append(roleDescription)
                    }
                }
                
                let view = await ProfileCardView(
                    title: "\(userInfo.firstName ?? "") \(userInfo.lastName ?? "")",
                    subTitle: userInfo.admin ?? false ? "Администратор" : rolesInfo.joined(separator: ",")
                )
                
                DispatchQueue.main.async { [weak self] in
                    self?.delegate?.insertCardView(view, at: 0)
                    self?.delegate?.insertCardView(SpaceCardView(height: 8), at: 1)
                }
            }
        }
    }
}

// TODO: По хорошему вынести в общее использование, возможно в Networking feature!!!

// MARK: - Endpoint

private struct UserInfoEndpoint: Endpoint {
    var method: HTTPMethod = .get
    var path: String = "/api/fmh/authentication/userInfo"
}

private struct RolesEndpoint: Endpoint {
    var method: HTTPMethod = .get
    var path: String = "/api/fmh/authentication/roles"
}

// MARK: - DTO

private struct UserInfo: Decodable {
    
    let id: Int?
    let firstName: String?
    let lastName: String?
    let middleName: String?
    let roles: [String]?
    let email: Email?
    let isConfirmed: Bool?
    let admin: Bool?
    
    struct Email: Decodable  {
        let name: String?
        let confirmed: Bool?
    }
}

private struct Roles: Decodable {
    let id: Int?
    let name: String?
    let description: String?
    let needConfirm: Bool
}
