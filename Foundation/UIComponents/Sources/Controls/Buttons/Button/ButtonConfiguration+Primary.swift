
import UIKit

// MARK: ButtonConfiguration + Primary

extension ButtonConfiguration {
    
    public static func primary(_ size: ControlSize? = .large) -> ButtonConfiguration {
        .init(
            size: size?.rawValue,
            corners: .init(radius: 8),
            highlightedScale: 0.98,
            styles: [
                .normal: .init(
                    backgroundColor: UIColor(hex: "#01A5A3"),
                    titleStyle: .init(color: UIColor(hex: "#FEFEFE"), font: .title)
                ),
                .disabled: .init(
                    backgroundColor: UIColor(hex: "#E7E7E7"),
                    titleStyle: .init(color: UIColor(hex: "#BABABA"), font: .title)
                ),
                .highlighted: .init(
                    backgroundColor: UIColor(hex: "#018482"),
                    titleStyle: .init(color: UIColor(hex: "#FEFEFE"), font: .title)
                )
            ]
        )
    }
}

// TODO: Сделать разные под размер кнопок!

private extension UIFont {
    static let title: UIFont = .interBold(ofSize: 20.0) ?? .boldSystemFont(ofSize: 20.0)
}
