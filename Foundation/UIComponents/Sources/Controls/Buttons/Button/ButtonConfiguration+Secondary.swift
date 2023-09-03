
import UIKit

// TODO: Сделать разные под размер экрана!

private extension UIFont {
    static let defaultButtonFont: UIFont = .interBold(ofSize: 20.0) ?? .boldSystemFont(ofSize: 20.0)
    static let smallButtonFont: UIFont = .interBold(ofSize: 13.0) ?? .boldSystemFont(ofSize: 13.0)
    static let mediumButtonFont: UIFont = .interBold(ofSize: 17.0) ?? .boldSystemFont(ofSize: 17.0)
    static let largeButtonFont: UIFont = .interBold(ofSize: 24.0) ?? .boldSystemFont(ofSize: 24.0)
}

// MARK: ButtonConfiguration + Primary

extension ButtonConfiguration {
    
    public struct secondary {
        
        public static let `default`: ButtonConfiguration = {
            .init(
                title: "secondary.default [\(CGSize.defaultSizeButton.height)]",
                state: .normal,
                style: .init(
                    size: .defaultSizeButton,
                    highlightedScale: 0.98,
                    backgroundColors: [
                        .init(state: .normal,
                              color: .clear),
                        .init(state: .highlighted,
                              color: UIColor(red: 0, green: 0.52, blue: 0.51, alpha: 1)),
                        .init(state: .disabled,
                              color: .clear)
                    ],
                    titleStyles: [
                        .init(state: .normal,
                              color: UIColor(red: 0, green: 0.65, blue: 0.64, alpha: 1),
                              font: .defaultButtonFont),
                        .init(state: .highlighted,
                              color: UIColor(red: 1, green: 1, blue: 1, alpha: 1),
                              font: .defaultButtonFont),
                        .init(state: .disabled,
                              color: UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1),
                              font: .defaultButtonFont)
                    ],
                    corners: .init(radius: 8.0),
                    borders: [
                        .init(state: .normal, borders: .init(
                            cgColor: UIColor(red: 0.004, green: 0.647, blue: 0.639, alpha: 1).cgColor,
                            width: 1.0)
                        ),
                        .init(state: .disabled, borders: .init(
                            cgColor: UIColor(red: 0.729, green: 0.729, blue: 0.729, alpha: 1).cgColor,
                            width: 1.0)
                        )
                    ]
                )
            )
        }()
        
        public static let small: ButtonConfiguration = {
            var configuration = ButtonConfiguration.secondary.default
            configuration.title = "secondary.small [\(CGSize.smallSizeButton.height)]"
            configuration.style.size = .smallSizeButton
            configuration.style.titleStyles.modify { $0.font = .smallButtonFont }
            return configuration
        }()
        
        public static let medium: ButtonConfiguration = {
            var configuration = ButtonConfiguration.secondary.default
            configuration.title = "secondary.medium [\(CGSize.mediumSizeButton.height)]"
            configuration.style.size = .mediumSizeButton
            configuration.style.titleStyles.modify { $0.font = .mediumButtonFont }
            return configuration
        }()
        
        public static let large: ButtonConfiguration = {
            var configuration = ButtonConfiguration.secondary.default
            configuration.title = "secondary.large [\(CGSize.largeSizeButton.height)]"
            configuration.style.size = .largeSizeButton
            configuration.style.titleStyles.modify { $0.font = .largeButtonFont }
            return configuration
        }()
    }
}
