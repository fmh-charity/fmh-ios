
import UIKit

private extension UIFont {
    static let text: UIFont = .interRegular(ofSize: 15.0) ?? .systemFont(ofSize: 15.0)
}

private extension UIColor {
    static let leftIcon: UIColor = UIColor(red: 0.32, green: 0.32, blue: 0.34, alpha: 1)
    static let text: UIColor = UIColor(red: 0.32, green: 0.32, blue: 0.34, alpha: 1)
    static let border: UIColor =  UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1)
}

private extension UIView {
    static func leftIcon(size: CGFloat, color: UIColor) -> UIImageView {
        let image = UIImage(systemName: "magnifyingglass")?.withTintColor(color, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: size).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: size).isActive = true
        return imageView
    }
}

// MARK: - TextFieldConfiguration + search

extension TextFieldConfiguration {
    
    public struct search {
        
        public static func `default`(_ size: ControlSize = .default) -> TextFieldConfiguration {
            .init(
                text: nil,
                placeholder: "ButtonConfiguration.search",
                state: nil,
                style: .init(
                    size: .init(width: .zero, height: size.rawValue),
                    contentEdgeInsets: .init(top: 0, left: 8, bottom: 0, right: 8),
                    backgroundColors: [
                        .init(state: .normal, color: .clear)
                    ],
                    texts: [
                        .init(state: .normal, color: .text, font: .text),
                        .init(state: .disabled, color: .text, font: .text)
                    ],
                    placeholders: [
                        .init(state: .normal, color: .lightGray, font: .text)
                    ],
                    clearButtonMode: .whileEditing,
                    leftViews: [
                        .init(state: .normal, view: .leftIcon(size: 28.0, color: .leftIcon))
                    ],
                    leftViewMode: .always,
                    leftViewEdgeInsets: .init(top: 0, left: 8, bottom: 0, right: 0),
                    corners: .init(radius: 8),
                    borders: [
                        .init(state: .normal, borders: .init(cgColor: UIColor.border.cgColor, width: 1))
                    ]
                )
            )
        }
    }
}
