
import UIKit

// MARK: ButtonConfiguration + `default`

extension ButtonConfiguration {
    
    /*
     Конфигурация по умолчанию.
     */
    public static func `default`(_ size: ControlSize? = .large) -> ButtonConfiguration {
        .init(
            size: size?.rawValue,
            highlightedScale: 0.98,
            highlightedOpacity: 0.8,
            styles: [
                .normal: .init(
                    backgroundColor: .systemBlue,
                    titleStyle: .init(color: .white, font: .title)
                ),
                .disabled: .init(
                    backgroundColor: .systemBlue,
                    titleStyle: .init(color: .white, font: .title)
                )
            ]
        )
    }
}

// TODO: Сделать разные под размер кнопок!

private extension UIFont {
    static let title: UIFont = .interBold(ofSize: 20.0) ?? .boldSystemFont(ofSize: 20.0)
}
