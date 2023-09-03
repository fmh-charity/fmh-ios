
import UIKit

extension TextFieldConfiguration {
    
    /*
     Example конфигурация.
     Со всеми параметрами, для удобства конфигурирования других.
     */
    public static func `default`(_ size: ControlSize = .default) -> TextFieldConfiguration {
        .init(
            text: nil,
            placeholder: "ButtonConfiguration.default",
            state: nil,
            style: .init(
                size: .init(width: .zero, height: size.rawValue),
                contentEdgeInsets: .init(top: 0, left: 8, bottom: 0, right: 8),
                backgroundColors: [
                    .init(state: .normal, color: .clear)
                ],
                texts: [
                    .init(state: .normal, color: .black, font: .systemFont(ofSize: 17)),
                    .init(state: .disabled, color: .darkGray, font: .systemFont(ofSize: 17))
                ],
                placeholders: [
                    .init(state: .normal, color: .lightGray, font: .systemFont(ofSize: 17))
                ],
                clearButtonMode: nil,
                leftViews: nil,
                leftViewMode: nil,
                leftViewEdgeInsets: nil,
                rightViews: nil,
                rightViewMode: nil,
                rightViewEdgeInsets: nil,
                corners: .init(radius: 8),
                borders: [
                    .init(state: .normal, borders: .init(cgColor: UIColor.lightGray.cgColor, width: 1))
                ]
            )
        )
    }
}
