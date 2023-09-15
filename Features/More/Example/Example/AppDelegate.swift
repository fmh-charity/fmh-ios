
import UIKit
import More
import Networking

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    lazy var moreAssembly: MoreAssemblyProtocol = {
        
        UserDefaults.standard.setValue(
            "eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ2b2xvbnRlcmhvc3Bpc0ByYW1ibGVyLnJ1IiwianRpIjoiNTEiLCJleHAiOjE2OTQ4OTI4MjN9.KJqS0YrqqkfWFeEMfGo3V5pyKRWBJuFO9WUIn5dzlhn1iaSKfqQP97BuxAasDBHeipuE9kmcQ2ohyW7uI2dWXA",
            forKey: "accessToken"
        )
        
        return MoreAssembly(dependencies:
                .init(
                    network: NetworkingProvider(host: "https://test.vhospice.org", urlSession: .shared)
                )
        )
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let vc = moreAssembly.moreViewController
        let nc = UINavigationController(rootViewController: vc)
        nc.navigationBar.prefersLargeTitles = true
        window?.rootViewController = nc
        
        return true
    }
}
