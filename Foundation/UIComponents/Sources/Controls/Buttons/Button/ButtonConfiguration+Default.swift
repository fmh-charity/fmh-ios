
import UIKit

extension ButtonConfiguration {
    
    /*
     Example конфигурация.
     Со всеми параметрами, для удобства конфигурирования других.
     */
    public static func `default`(_ size: ControlSize = .default) -> ButtonConfiguration {
        .init(
            title: "ButtonConfiguration.default",
            state: .normal,
            style: .init(
                size: CGSize(width: .zero, height: size.rawValue),
                isCapsule: false,
                highlightedScale: 0.98,
                highlightedOpacity: 0.8,
                backgroundColors: [.init(state: .normal, color: .systemBlue)],
                titleStyles: [.init(state: .normal, color: .white, font: .boldSystemFont(ofSize: 17))],
                corners: nil,
                borders: nil,
                shadows: nil
            )
        )
    }
}
