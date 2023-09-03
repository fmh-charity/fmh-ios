
import UIKit

extension TextFieldWithState {
    
    public enum State: String, CaseIterable, Equatable  {
        case normal
        case disabled
        case focused
        case readOnly
        case warning
        case error
    }
}

// MARK: - TextFieldWithState.State.StateStyle

public extension TextFieldWithState.State {
    
    var style: TextFieldWithStateConfiguration.StateStyle? {
        switch self {
        case .normal:
            return .init(
                borderColor: UIColor(hex: "#BABABA"),
                titleStyle: (UIColor(hex: "#525256"), .title),
                textStyle: (UIColor(hex: "#525256"), .text),
                placeholderStyle: (UIColor(hex: "#BABABA"), .placeholder),
                promptStyle: (UIColor(hex: "#525256"), .prompt),
                clearButtonImage: .clearImage(color: UIColor(hex: "#525256"))
            )
        case .disabled:
            return .init(
                borderColor: UIColor(hex: "#BABABA"),
                titleStyle: (UIColor(hex: "#BABABA"), .title),
                textStyle: (UIColor(hex: "#BABABA"), .text),
                placeholderStyle: (UIColor(hex: "#BABABA"), .title),
                promptStyle: (UIColor(hex: "#BABABA"), .title),
                clearButtonImage: .clearImage(color: UIColor(hex: "#BABABA"))
            )
        case .focused:
            return .init(
                borderColor: UIColor(hex: "#01A5A3"),
                textStyle: (UIColor(hex: "#080C0C"), .text)
            )
        case .readOnly:
            return .init(
                borderColor: .clear,
                textStyle: (UIColor(hex: "#080C0C"), .textBold),
                clearButtonImage: UIImage()
            )
        case .warning:
            return .init(
                borderColor: UIColor(hex: "#E9A23B"),
                textStyle: (UIColor(hex: "#080C0C"), .text),
                promptStyle: (UIColor(hex: "#E9A23B"), .title)
            )
        case .error:
            return .init(
                borderColor: UIColor(hex: "#F34141"),
                textStyle: (UIColor(hex: "#080C0C"), .text),
                promptStyle: (UIColor(hex: "#F34141"), .title)
            )
        }
    }
}

// MARK: - Helpers

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
        let image = UIImage(systemName: "xmark", withConfiguration: configuration)
        return image?.withTintColor(color, renderingMode: .alwaysOriginal)
    }
}
