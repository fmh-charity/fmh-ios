//
//  SideMenuTableHeaderView.swift
//  fmh
//
//  SideMenuTopView: 14.12.2022
//

import UIKit

private enum Constant {
    static let backgroundColor = UIColor.clear
    static let titleColor = UIColor(hex: "#535353")
    static let subTitleColor = UIColor.systemGray
    static let logoutButtonSize = 44.0
    static let logoutButtonImage = UIImage(systemName: "rectangle.portrait.and.arrow.right")
    static let logoutButtonTintColor = UIColor.accentColor
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
    
    var logoutDidTap: (() -> Void)?
    
    // MARK: - UI
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.textColor = Constant.titleColor
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var subTitle: UILabel = {
        let label = UILabel()
        label.textColor = Constant.subTitleColor
        label.font = UIFont.systemFont(ofSize: 11)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(Constant.logoutButtonImage, for: .normal)
        button.tintColor = Constant.logoutButtonTintColor
        button.addTarget(self, action: #selector(logoutButtonTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackInfo: UIStackView = {
        let view = UIStackView(arrangedSubviews: [title, subTitle])
        view.axis = .vertical
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
        addSubviews(stackInfo, logoutButton) {[
            stackInfo.topAnchor.constraint(greaterThanOrEqualTo: topAnchor),
            stackInfo.leftAnchor.constraint(equalTo: leftAnchor),
            stackInfo.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor),
            stackInfo.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            logoutButton.widthAnchor.constraint(equalToConstant: Constant.logoutButtonSize),
            logoutButton.heightAnchor.constraint(equalToConstant: Constant.logoutButtonSize),
            logoutButton.topAnchor.constraint(equalTo: topAnchor),
            logoutButton.rightAnchor.constraint(equalTo: rightAnchor),
            logoutButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            logoutButton.leftAnchor.constraint(equalTo: stackInfo.rightAnchor)
        ]}
    }
    
    // MARK: - Actions
    
    @objc private func logoutButtonTap() {
        logoutDidTap?()
    }
    
    // MARK: - Model
    
    struct Model {
        let title: String
        let subtitle: String
    }
}
