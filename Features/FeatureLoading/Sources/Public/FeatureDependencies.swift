
import Foundation

public struct FeatureDependencies {

    public var onCompletion: (() -> Void)?
    
    public init(onCompletion: (() -> Void)? = nil) {
        self.onCompletion = onCompletion
    }
}
