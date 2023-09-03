
import UIKit
import UIComponents

private extension UIFont {
    static let greetingsTitleFont: UIFont = .interExtraBold(ofSize: 30.0) ?? .boldSystemFont(ofSize: 30.0)
    static let greetingsDescriptionFont: UIFont = .interRegular(ofSize: 16.0) ?? .systemFont(ofSize: 16.0)
}

extension AuthorizationViewController {
    
    final class BlockInfoView: UIView {
        
        // MARK: - UI
        
        private lazy var greetings: UILabel = {
            $0.textAlignment = .center
            $0.font = .greetingsTitleFont
            $0.textColor = UIColor(red: 1/255, green: 165/255, blue: 163/255, alpha: 1)
            return $0
        }(UILabel())
        
        private lazy var greetingsDescription: UILabel = {
            $0.textAlignment = .center
            $0.font = .greetingsDescriptionFont
            $0.textColor = UIColor(red: 0.322, green: 0.322, blue: 0.337, alpha: 1)
            return $0
        }(UILabel())
        
        // MARK: - Life cycle

        init(
            greetings: String,
            greetingsDescription: String
        ) {
            super.init(frame: .zero)
            self.greetings.text = greetings
            self.greetingsDescription.text = greetingsDescription
            setupUI()
        }
       
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        // MARK: - Setup UI
        
        func setupUI() {
            addSubviews(greetings, greetingsDescription) {[
                greetings.topAnchor.constraint(equalTo: topAnchor),
                greetings.leadingAnchor.constraint(equalTo: leadingAnchor),
                greetings.trailingAnchor.constraint(equalTo: trailingAnchor),
                greetingsDescription.topAnchor.constraint(equalTo: greetings.bottomAnchor, constant: 8),
                greetingsDescription.leadingAnchor.constraint(equalTo: leadingAnchor),
                greetingsDescription.trailingAnchor.constraint(equalTo: trailingAnchor),
                greetingsDescription.bottomAnchor.constraint(equalTo: bottomAnchor)
            ]}
        }
    }
}
