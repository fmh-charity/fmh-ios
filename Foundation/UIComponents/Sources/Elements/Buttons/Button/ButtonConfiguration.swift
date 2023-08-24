
import UIKit

// MARK: Конфигурация Button

public struct ButtonConfiguration {
    
    public var title: String?
    public var style: ButtonStyle
    
    public init(
        title: String? = nil,
        style: ButtonStyle
    ) {
        self.title = title
        self.style = style
    }
}
