
import Foundation
import Networking

protocol MenuViewPresenterProtocol {
    func fetchUserInfo(completion: @escaping (SideMenuTopView.Model?, Error?)->Void)
}

class MenuViewPresenter {
    
    // Dependencies
    private let networkService: NetworkProtocol
    
    // MARK: - Life cycle
    
    public init(networkService: NetworkProtocol) {
        self.networkService = networkService
    }
}

// MARK: - MenuViewPresenterProtocol

extension MenuViewPresenter: MenuViewPresenterProtocol {
    
    func fetchUserInfo(completion: @escaping (SideMenuTopView.Model?, Error?) -> Void) {
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
                
                let admin = userInfo.admin ?? false ? "Администратор" : rolesInfo.joined(separator: ",")
                let model = SideMenuTopView.Model(title: "\(userInfo.firstName ?? "") \(userInfo.lastName ?? "")", subtitle: admin)
                
                DispatchQueue.main.async {
                    completion(model, nil)
                }
            } catch {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
    }
}

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
