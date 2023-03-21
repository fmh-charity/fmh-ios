//
//  SideMenuTableHeaderView.swift
//  fmh
//
//  SideMenuTopView: 14.12.2022
//

import Foundation
import UIKit

final class SideMenuTopView: UIView {
    
    // MARK: - UI
    
    private lazy var imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.backgroundColor = .clear
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    private lazy var divider: UIView = {
        let imgView = UIView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.backgroundColor = .lightGray
        imgView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        return imgView
    }()
    
    // MARK: - LifeCycle
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup UI
    
    private func configure() {
        backgroundColor = .clear
        
        imgView.image = UIImage(named: "logo")
        
        addSubviews([imgView])

        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: topAnchor),
            imgView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imgView.heightAnchor.constraint(equalToConstant: 44),
            imgView.widthAnchor.constraint(equalTo: widthAnchor),
            
//            divider.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
//            divider.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//            divider.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -9),
        ])
    }
}
