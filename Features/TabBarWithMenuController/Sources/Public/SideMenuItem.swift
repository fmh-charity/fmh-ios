
import UIKit

public enum SideMenuSection: Int { case general = 0, secondary, settings }

public struct SideMenuItem {
    
    public let tag: String
    public let image: UIImage
    public let title: String
    public var didSelect: (() -> Void)?
    
    public init(
        tag: String,
        image: UIImage,
        title: String,
        didSelect: (() -> Void)? = nil
    ) {
        self.tag = tag
        self.image = image
        self.title = title
        self.didSelect = didSelect
    }
}
