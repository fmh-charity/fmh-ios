//
//  SideMenuBottomView.swift
//  fmh
//
//  Created: 14.12.2022
//

import Foundation
import UIKit


final class SideMenuBottomView: UIView {
    
    var cardColor: UIColor = UIColor(hex: "#01A19F")
    var cardBorderColor: UIColor = .white
    
    var model: Model? {
        didSet {
            guard let model else { return }
            profileId.text = model.profileId
            profileTitle.text = model.profileTitle
            profileSubTitle.text = model.profileSubTitle
        }
    }
    
    var logoutDidTap: (() -> Void)?
    var profileDidTap: (() -> Void)?
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        setLayouts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var appVersionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 11)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "App version: " + (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "?")
        return label
    }()
    
    // Info
    private lazy var profileTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var profileSubTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 11)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var profileId: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    // Buttons
    private let buttonsHeight = 24.0
    private lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = buttonsHeight/2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.backgroundColor = .white
        button.setTitle("Выйти", for: .normal)
        button.setTitleColor(cardColor, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.addTarget(self, action: #selector(logoutButtonTap), for: .touchUpInside)
        return button
    }()
    
    private lazy var buttonsWrapper: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        view.addSubviews([profileId, logoutButton])
        NSLayoutConstraint.activate([
            profileId.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileId.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            logoutButton.leadingAnchor.constraint(equalTo: profileId.trailingAnchor, constant: 16),
            logoutButton.topAnchor.constraint(equalTo: view.topAnchor),
            logoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            logoutButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4),
            logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        return view
    }()

    private lazy var infoWrapper: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        
        view.addSubviews([profileTitle, profileSubTitle , buttonsWrapper])
        NSLayoutConstraint.activate([
            profileTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            profileTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            profileTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            profileSubTitle.topAnchor.constraint(equalTo: profileTitle.bottomAnchor, constant: 2),
            profileSubTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            profileSubTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            buttonsWrapper.topAnchor.constraint(equalTo: profileSubTitle.bottomAnchor, constant: 8),
            buttonsWrapper.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            buttonsWrapper.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            buttonsWrapper.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        return view
    }()
    
    private lazy var cardWrapper: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = cardColor
        
        view.layer.cornerRadius = 12
        view.layer.borderWidth = 0.7
        view.layer.borderColor = cardBorderColor.cgColor
        
        view.addSubview(infoWrapper)
        NSLayoutConstraint.activate([
            infoWrapper.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
            infoWrapper.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            infoWrapper.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            infoWrapper.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
        ])
        
        let gestureTap = UITapGestureRecognizer(target: self, action: #selector(profileTap))
        view.addGestureRecognizer(gestureTap)
        
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [
            cardWrapper,
            appVersionLabel
        ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.alignment = .fill
        stack.axis = .vertical
        stack.spacing = 16
        return stack
    }()
    
    private func setLayouts() {
        backgroundColor = .clear

        addSubviews([stackView])
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
            
        ])
        
    }
    
    @objc private func logoutButtonTap() { logoutDidTap?() }
    @objc private func profileTap() { profileDidTap?() }
    
    struct Model {
        let profileId: String
        let profileImg: UIImage?
        let profileTitle: String
        let profileSubTitle: String
    }
    
}


/*
#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct SideMenuBottomViewRepresentable: UIViewRepresentable {
    typealias UIViewType = SideMenuBottomProfileCardView
    
    func makeUIView(context: Context) -> UIViewType {
        let view = SideMenuBottomProfileCardView()
        let img = UIImage(systemName: "person")
        view.model = .init(profileImg: img, profileTitle: "Иванов Иван", profileSubTitle: "Администратор")
        view.backgroundColor = .init(hex: "#01A19F")
        return view
    }

    func updateUIView(_ uiView: SideMenuBottomProfileCardView, context: Context) { }
}

struct BackgroundViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SideMenuBottomViewRepresentable().colorScheme(.light)
        }.previewLayout(.fixed(width: 280, height: 150))
            
    }
}

#endif
*/
