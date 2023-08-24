
import UIKit

public extension ButtonConfiguration {
    
    // MARK: - Basic buttons
    
    static func `default`(_ size: ButtonSize = .default) -> ButtonConfiguration {
        .init(
            title: "ButtonConfiguration.default",
            style: .init(
                size: .init(width: .zero, height: size.rawValue),
                backgroundColor: Color.button.default,
                stateStyles: [
                    .init(
                        state: .normal,
                        titleStyle: .init(color: Color.title.default, font: Font.button.default)
                    )
                ]
            )
        )
    }
    
    static func plain(_ size: ButtonSize = .default) -> ButtonConfiguration {
        .init(
            title: "ButtonConfiguration.plain",
            style: .init(
                size: .init(width: .zero, height: size.rawValue),
                stateStyles: [
                    .init(
                        state: .normal,
                        titleStyle: .init(color: Color.button.plainTitle, font: Font.button.default)
                    )
                ]
            )
        )
    }
    
    // MARK: - FMH buttons
    
    static let primary: ButtonConfiguration = {
        ButtonConfiguration.default()
    }()
    
    static let secondary: ButtonConfiguration = {
        ButtonConfiguration.default()
    }()
    
    static let outlined: ButtonConfiguration = {
        ButtonConfiguration.default()
    }()
    
    // MARK:
    
    static let roundedFill: ButtonConfiguration = {
        .init(
            title: "roundedFill",
            style: .init(
                size: .init(width: .zero, height: 44.0),
                backgroundColor: .darkGray,
                corners: .init(radius: 22.0)
//                stateStyles: [
//                    .init(state: .normal,
//                          titleStyle: .init(color: .orange, font: .italicSystemFont(ofSize: 16))
//                         ),
//                    .init(state: .highlighted,
//                          titleStyle: .init(color: .green, font: .italicSystemFont(ofSize: 14))
//                         )
//                ]
            ))
    }()
}
