
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

public extension ButtonConfiguration {
    
    /*
     Example конфигурация.
     Со всеми параметрами, для удобства конфигурирования других.
     */
    static func `default`(_ size: ButtonSize = .default) -> ButtonConfiguration {
        .init(
            title: "ButtonConfiguration.default",
            style: .init(
                size: CGSize(width: .zero, height: size.rawValue),
                isCapsule: false,
                highlightedScale: 0.98,
                highlightedOpacity: 0.8,
                backgroundColors: [.init(state: .normal, color: .systemBlue)],
                titleStyles: [.init(state: .normal, color: .white, font: .boldSystemFont(ofSize: 18))],
                corners: nil,
                borders: nil,
                shadows: nil
            )
        )
    }
}
