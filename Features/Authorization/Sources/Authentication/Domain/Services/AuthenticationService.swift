
import Foundation

protocol AuthenticationServiceProtocol {
    func login(login: String, password: String, completion: @escaping (Error?) -> Void)
}

final class AuthenticationService {
    
    // Dependencies
    private var networkService: NetworkServiceProtocol
    private var tokenProvider: TokenProviderProtocol
    
    init(
        networkService: NetworkServiceProtocol,
        tokenProvider: TokenProviderProtocol
    ) {
        self.networkService = networkService
        self.tokenProvider = tokenProvider
    }
}

// MARK: - AuthenticationServiceProtocol

extension AuthenticationService: AuthenticationServiceProtocol {
    
    func login(login: String, password: String, completion: @escaping (Error?) -> Void) {
        var endpoint = NetworkService.Endpoint(method: .post, path: "/api/fmh/authentication/login")
        endpoint.body = try? ["login": login, "password": password].data()
        networkService.fetch(endpoint: endpoint) { [weak self] error, decodeData in
            guard let tokens: DTOJWT = decodeData else {
                DispatchQueue.main.async {
                    completion(error)
                }
                return
            }
            self?.tokenProvider.updateTokens(accessToken: tokens.accessToken, refreshToken: tokens.refreshToken)
            DispatchQueue.main.async {
                completion(nil)
            }
        }
    }
}
