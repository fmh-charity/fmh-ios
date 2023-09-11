
import UIKit

// MARK: - TextFieldBasicConfiguration + `default`

extension TextFieldBasicConfiguration {
    
    /*
     Конфигурация по умолчанию.
     */
    public static func `default`(_ size: ControlSize? = .default) -> TextFieldBasicConfiguration {
        .init(
            size: size?.rawValue,
            corners: .init(radius: 8),
            textEdgeInsets: .init(top: 0, left: 8, bottom: 0, right: 8),
            clearButtonMode: .whileEditing,
            styles: [
                .normal: .init(
                    borders: .init(cgColor: UIColor.border.cgColor, width: 1),
                    textStyle: .init(color: .black, font: .text),
                    placeholderStyle: .init(color: .lightGray, font: .placeholder)
                ),
                .disabled: .init(
                    textStyle: .init(color: .darkGray, font: .text)
                )
            ]
        )
    }
}

// MARK: - Helpers

// TODO: Сделать разные под размер кнопок!

private extension UIFont {
    static let text: UIFont = .interRegular(ofSize: 17.0) ?? .systemFont(ofSize: 17.0)
    static let placeholder: UIFont = .interRegular(ofSize: 17.0) ?? .systemFont(ofSize: 17.0)
}

private extension UIColor {
    static let border: UIColor = UIColor.lightGray
}
