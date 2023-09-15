
import UIKit
import UIComponents

final class SimpleCardView: UIView {
    
    // MARK: UI
    
    private var avatarImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.widthAnchor.constraint(equalToConstant: 36).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 36).isActive = true
        $0.layer.cornerRadius = 36/2
        return $0
    }(UIImageView())
    
    private var titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .interMedium(ofSize: 20.0) ?? .systemFont(ofSize: 20.0)
        $0.textColor = UIColor(hex: "#080C0C")
        return $0
    }(UILabel())
    
    // MARK: - Life cycle
    
    init(
        imageName: String? = nil,
        title: String
    ) {
        super.init(frame: .zero)
        setupLayouts()
        // Configure
        if let imageName {
            if let image = UIImage(named: imageName, in: .module, with: .none) {
                avatarImage.image = image.withTintColor(Color.accent, renderingMode: .alwaysOriginal)
            } else {
                let image = UIImage(systemName: imageName)
                avatarImage.image = image?.withTintColor(Color.accent, renderingMode: .alwaysOriginal)
            }
        }
        titleLabel.text = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup layouts
    
    private func setupLayouts() {
        backgroundColor = UIColor(hex: "#FFFFFF")
        layer.cornerRadius = 12
        
        let offset = 16.0
        addSubview(avatarImage)
        addSubview(titleLabel)

        avatarImage.topAnchor.constraint(equalTo: topAnchor, constant: offset).isActive = true
        avatarImage.leftAnchor.constraint(equalTo: leftAnchor, constant: offset).isActive = true
        avatarImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -offset).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: offset).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: offset).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -offset).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -offset).isActive = true
    }
}
