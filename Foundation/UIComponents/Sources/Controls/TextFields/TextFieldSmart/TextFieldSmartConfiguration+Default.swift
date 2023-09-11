
import UIKit

// MARK: - TextFieldSmartConfiguration + `default`

extension TextFieldSmartConfiguration {
    
    /*
     Конфигурация по умолчанию.
     */
    public static func `default`(_ size: ControlSize? = .large) -> TextFieldSmartConfiguration {
        .init(
            size: size?.rawValue,
            corners: .init(radius: 8),
            contentEdgeInsets: .init(top: 6, left: 0, bottom: 6, right:  0),
            textEdgeInsets: .init(top: 12, left: 12, bottom: 12, right:  32),
            clearButtonEdgeInsets: .init(top: 0, left: 0, bottom: 0, right:  6),
            clearButtonMode: .whileEditing,
            styles: [
                .normal: .init(
                    borders: .init(cgColor: UIColor(hex: "#BABABA").cgColor, width: 1),
                    titleStyle: .init(color: UIColor(hex: "#525256"), font: .title),
                    textStyle: .init(color: UIColor(hex: "#525256"), font: .text),
                    placeholderStyle: .init(color: UIColor(hex: "#BABABA"), font: .placeholder),
                    promptStyle: .init(color: UIColor(hex: "#525256"), font: .prompt),
                    clearButtonImage: .clearImage(color: UIColor(hex: "#525256"))
                ),
                .disabled: .init(
                    borders: .init(cgColor: UIColor(hex: "#BABABA").cgColor, width: 1),
                    titleStyle: .init(color: UIColor(hex: "#BABABA"), font: .title),
                    textStyle: .init(color: UIColor(hex: "#BABABA"), font: .text),
                    placeholderStyle: .init(color: UIColor(hex: "#BABABA"), font: .title),
                    promptStyle: .init(color: UIColor(hex: "#BABABA"), font: .title),
                    clearButtonImage: .clearImage(color: UIColor(hex: "#BABABA"))
                ),
                .focused: .init(
                    borders: .init(cgColor: UIColor(hex: "#01A5A3").cgColor, width: 1),
                    textStyle: .init(color: UIColor(hex: "#080C0C"), font: .text),
                    clearButtonImage: .clearImage(color: UIColor(hex: "#525256"))
                ),
                .readOnly: .init(
                    borders: .init(cgColor: UIColor.clear.cgColor, width: 1),
                    titleStyle: .init(color: UIColor(hex: "#525256"), font: .title),
                    textStyle: .init(color: UIColor(hex: "#080C0C"), font: .textBold),
                    clearButtonImage: UIImage()
                ),
                .warning: .init(
                    borders: .init(cgColor: UIColor(hex: "#E9A23B").cgColor, width: 1),
                    titleStyle: .init(color: UIColor(hex: "#525256"), font: .title),
                    textStyle: .init(color: UIColor(hex: "#080C0C"), font: .text),
                    promptStyle: .init(color: UIColor(hex: "#E9A23B"), font: .title),
                    clearButtonImage: .clearImage(color: UIColor(hex: "#525256"))
                ),
                .error: .init(
                    borders: .init(cgColor: UIColor(hex: "#F34141").cgColor, width: 1),
                    titleStyle: .init(color: UIColor(hex: "#525256"), font: .title),
                    textStyle: .init(color: UIColor(hex: "#080C0C"), font: .text),
                    promptStyle: .init(color: UIColor(hex: "#F34141"), font: .title),
                    clearButtonImage: .clearImage(color: UIColor(hex: "#525256"))
                )
            ]
        )
    }
}

// MARK: - Helpers

// TODO: Сделать разные под размер кнопок!

private extension UIFont {
    static let title: UIFont = .interRegular(ofSize: 15.0) ?? .systemFont(ofSize: 15.0)
    static let text: UIFont = .interRegular(ofSize: 17.0) ?? .systemFont(ofSize: 17.0)
    static let textBold: UIFont = .interBold(ofSize: 17.0) ?? .boldSystemFont(ofSize: 17.0)
    static let placeholder: UIFont = .interRegular(ofSize: 17.0) ?? .systemFont(ofSize: 17.0)
    static let prompt: UIFont = .interRegular(ofSize: 15.0) ?? .systemFont(ofSize: 15.0)
}

private extension UIImage {
    static func clearImage(color: UIColor) -> UIImage? {
        let configuration = UIImage.SymbolConfiguration(weight: .medium)
        var image = UIImage(systemName: "xmark", withConfiguration: configuration)
        image = image?.imageWithInsets(insets: .init(top: 0, left: 0, bottom: 0, right: 6))
        return image?.withTintColor(color, renderingMode: .alwaysOriginal)
    }
}
