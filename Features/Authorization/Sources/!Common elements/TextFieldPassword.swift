
import UIKit
import UIComponents

public final class TextFieldPassword: TextFieldSmart {
    
    // MARK: - UI
    
    private lazy var button: UIButton = {
        let image: UIImage? = .passwordButtonImage(color: UIColor(hex: "#525256"), isVisible: false)
        $0.setImage(image, for: .normal)
        $0.addTarget(self, action: #selector(passwordButtonAction), for: .touchUpInside)
        $0.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return $0
    }(UIButton(type: .custom))
    
    // MARK: - Life cycle
    
    public override init(configuration: TextFieldSmartConfiguration) {
        super.init(configuration: configuration)
        configure()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Position views
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: .init(top: 0, left: 0, bottom: 0, right: 6))
    }
    
    // MARK: - Configure
    
    private func configure() {
        rightView?.tag = 0
        isSecureTextEntry = true
        rightViewMode = .always
        rightView = self.button
    }
    
    @objc private func passwordButtonAction() {
        if rightView?.tag == 0 {
            rightView?.tag = 1
            let image: UIImage? = .passwordButtonImage(color: UIColor(hex: "#525256"), isVisible: true)
            self.button.setImage(image, for: .normal)
            isSecureTextEntry = false
        } else {
            let image: UIImage? = .passwordButtonImage(color: UIColor(hex: "#525256"), isVisible: false)
            self.button.setImage(image, for: .normal)
            rightView?.tag = 0
            isSecureTextEntry = true
        }
    }
}

// MARK: - Helpers

private extension UIImage {
    static func passwordButtonImage(color: UIColor, isVisible: Bool) -> UIImage? {
        let configuration = UIImage.SymbolConfiguration(weight: .medium)
        let imageName = isVisible ? "eye" : "eye.slash"
        let image = UIImage(systemName: imageName, withConfiguration: configuration)
        return image?.withTintColor(color, renderingMode: .alwaysOriginal)
    }
}
