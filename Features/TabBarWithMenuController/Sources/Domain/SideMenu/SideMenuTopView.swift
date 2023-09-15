
import UIKit
import UIComponents

private enum Constant {
    static let backgroundColor = UIColor.clear
    static let titleColor = UIColor(hex: "#535353")
    static let subTitleColor = UIColor.systemGray
    static let logoutButtonSize = 44.0
    static let logoutButtonImage = UIImage(systemName: "rectangle.portrait.and.arrow.right")
    static let logoutButtonTintColor = Color.accent
}

final class SideMenuTopView: UIView {
    
    // MARK: - Configure model
    
    var model: Model? {
        didSet {
            guard let model = model else {
                return
            }
            title.text = model.title
            subTitle.text = model.subtitle
        }
    }

    // MARK: - UI
    
    private lazy var title: UILabel = {
        $0.textColor = Constant.titleColor
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textAlignment = .center
        $0.numberOfLines = 1
        return $0
    }(UILabel())
    
    private lazy var subTitle: UILabel = {
        $0.textColor = Constant.subTitleColor
        $0.font = UIFont.systemFont(ofSize: 11)
        $0.textAlignment = .center
        $0.numberOfLines = 1
        return $0
    }(UILabel())
    
    private lazy var stackInfo: UIStackView = {
        let view = UIStackView(arrangedSubviews: [title, subTitle])
        view.axis = .vertical
        return view
    }()
    
    private lazy var wrapper: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 12
        view.addSubviews(stackInfo) {[
            stackInfo.topAnchor.constraint(greaterThanOrEqualTo: view.topAnchor, constant: 8),
            stackInfo.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
            stackInfo.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: -8),
            stackInfo.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8),
            stackInfo.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ]}
        return view
    }()
    
    // MARK: - LifeCycle
    
    init() {
        super.init(frame: .zero)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Common init
    
    private func commonInit() {
        backgroundColor = Constant.backgroundColor
        setupUI()
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        addSubviews(wrapper) {[
            wrapper.topAnchor.constraint(greaterThanOrEqualTo: topAnchor, constant: 8),
            wrapper.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            wrapper.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -8),
            wrapper.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
        ]}
    }
    
    // MARK: - Model
    
    struct Model {
        let title: String
        let subtitle: String
    }
}
