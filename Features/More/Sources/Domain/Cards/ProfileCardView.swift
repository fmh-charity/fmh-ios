
import UIKit
import UIComponents

final class ProfileCardView: UIView {
    
    // MARK: UI
    
    private var avatarImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.widthAnchor.constraint(equalToConstant: 60).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 60).isActive = true
        $0.layer.cornerRadius = 60/2
        $0.backgroundColor = Color.background
        return $0
    }(UIImageView())
    
    private var titleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .interBold(ofSize: 20.0) ?? .systemFont(ofSize: 20.0)
        $0.textColor = UIColor(hex: "#080C0C")
        return $0
    }(UILabel())
    
    private var subTitleLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = .interRegular(ofSize: 17.0) ?? .systemFont(ofSize: 17.0)
        $0.textColor = UIColor(hex: "#525256")
        return $0
    }(UILabel())
    
    private var arrowImage: UIImageView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(systemName: "chevron.right")?.withTintColor(.lightGray, renderingMode: .alwaysOriginal)
        return $0
    }(UIImageView())
    
    // MARK: - Life cycle
    
    init(
        avatarImageUrl: String? = nil,
        title: String,
        subTitle: String
    ) {
        super.init(frame: .zero)
        setupLayouts()
        // Configure
        // TODO: Нужен загрузчик картинок по url!
        if let _ = avatarImageUrl {
            // avatarImage.image =
        }
        titleLabel.text = title
        subTitleLabel.text = subTitle
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
        addSubview(subTitleLabel)
        addSubview(arrowImage)

        avatarImage.topAnchor.constraint(equalTo: topAnchor, constant: offset).isActive = true
        avatarImage.leftAnchor.constraint(equalTo: leftAnchor, constant: offset).isActive = true
        avatarImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -offset).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: offset).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: offset).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: arrowImage.leftAnchor).isActive = true
        
        subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0).isActive = true
        subTitleLabel.leftAnchor.constraint(equalTo: avatarImage.rightAnchor, constant: offset).isActive = true
        subTitleLabel.rightAnchor.constraint(equalTo: arrowImage.leftAnchor).isActive = true
        subTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -offset).isActive = true
        
        arrowImage.widthAnchor.constraint(equalToConstant: 24).isActive = true
        arrowImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        arrowImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -offset/2).isActive = true
        
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
    }
}
