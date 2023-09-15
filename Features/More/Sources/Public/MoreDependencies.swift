
import Networking

public struct MoreDependencies {

    public var onCompletion: (() -> Void)?
    public let network: NetworkProtocol
    
    public init(
        onCompletion: (() -> Void)? = nil,
        network: NetworkProtocol
    ) {
        self.onCompletion = onCompletion
        self.network = network
    }
}
