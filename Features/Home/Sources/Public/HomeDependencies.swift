
import Foundation

public struct HomeDependencies {

    public var onCompletion: (() -> Void)?
    
    public init(onCompletion: (() -> Void)? = nil) {
        self.onCompletion = onCompletion
    }
}
