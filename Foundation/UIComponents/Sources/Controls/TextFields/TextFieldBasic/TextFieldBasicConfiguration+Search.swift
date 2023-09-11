
import UIKit

// MARK: - TextFieldBasicConfiguration + search

extension TextFieldBasicConfiguration {
    
    /*
     Search конфигурация.
     */
    public static func search(_ size: ControlSize? = .default) -> TextFieldBasicConfiguration {
        .init(
            size: size?.rawValue,
            corners: .init(radius: 8),
            textEdgeInsets: .init(top: 0, left: 8, bottom: 0, right: 8),
            leftViewEdgeInsets: .init(top: 0, left: 8, bottom: 0, right: 0),
            rightViewEdgeInsets: .init(top: 0, left: 0, bottom: 0, right: 6),
            clearButtonMode: .whileEditing,
            leftViewMode: .always,
            styles: [
                .normal: .init(
                    borders: .init(cgColor: UIColor.border.cgColor, width: 1),
                    leftView: .leftIcon(size: 34, color: .leftIcon),
                    textStyle: .init(color: .text, font: .text),
                    placeholderStyle: .init(color: .placeholder, font: .placeholder)
                ),
                .disabled: .init(
                    leftView: .leftIcon(size: 34, color: UIColor(hex: "#BABABA")),
                    textStyle: .init(color: .darkGray, font: .text)
                )
            ]
        )
    }
}

// MARK: - Helpers

// TODO: Сделать разные под размер кнопок!

private extension UIFont {
    static let text: UIFont = .interRegular(ofSize: 15.0) ?? .systemFont(ofSize: 15.0)
    static let placeholder: UIFont = .interRegular(ofSize: 15.0) ?? .systemFont(ofSize: 17.0)
}

private extension UIColor {
    static let leftIcon: UIColor = UIColor(red: 0.32, green: 0.32, blue: 0.34, alpha: 1)
    static let text: UIColor = UIColor(red: 0.32, green: 0.32, blue: 0.34, alpha: 1)
    static let placeholder: UIColor = .lightGray
    static let border: UIColor =  UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
}

private extension UIView {
    static func leftIcon(size: CGFloat, color: UIColor) -> UIImageView {
        var image = UIImage(systemName: "magnifyingglass")?.withTintColor(color, renderingMode: .alwaysOriginal)
        image = image?.imageWithInsets(insets: .init(top: 0, left: 6, bottom: 0, right: 0))
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: size).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: size).isActive = true
        return imageView
    }
}
