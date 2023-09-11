
import UIKit

// MARK: ButtonConfiguration + secondary

extension ButtonConfiguration {
    
    public static func secondary(_ size: ControlSize? = .large) -> ButtonConfiguration {
        .init(
            size: size?.rawValue,
            corners: .init(radius: 8),
            highlightedScale: 0.98,
            styles: [
                .normal: .init(
                    backgroundColor: .clear,
                    borders: .init(cgColor: UIColor(hex: "#01A5A3").cgColor, width: 1.0),
                    titleStyle: .init(color: UIColor(hex: "#01A5A3"), font: .title)
                ),
                .disabled: .init(
                    backgroundColor: .clear,
                    borders: .init(cgColor: UIColor(hex: "#BABABA").cgColor, width: 1.0),
                    titleStyle: .init(color: UIColor(hex: "#BABABA"), font: .title)
                ),
                .highlighted: .init(
                    backgroundColor: UIColor(hex: "#01A5A3"),
                    borders: .init(cgColor: UIColor(hex: "#01A5A3").cgColor, width: 1.0),
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
