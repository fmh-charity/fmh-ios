//
//  AuthorizationViewController+BlockInfo.swift
//  
//
//  Created by Константин Туголуков on 19.08.2023.
//

import UIKit

extension AuthorizationViewController {
    
    final class BlockInfo: UIView {
        
        // MARK: Life cycle

        init(greetings: String, greetingsDescription: String) {
            super.init(frame: .zero)
            translatesAutoresizingMaskIntoConstraints = false
            self.greetings.text = greetings
            self.greetingsDescription.text = greetingsDescription
            setupUI()
        }
       
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        // MARK: - UI
        
        private lazy var greetings: UILabel = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 30)
            $0.textColor = UIColor(red: 1/255, green: 165/255, blue: 163/255, alpha: 1)
            return $0
        }(UILabel())
        
        private lazy var greetingsDescription: UILabel = {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 16)
            return $0
        }(UILabel())
        
        // MARK: - Setup UI
        
        func setupUI() {
            addSubview(greetings)
            addSubview(greetingsDescription)
            NSLayoutConstraint.activate([
                greetings.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                greetings.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                greetings.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                
                greetingsDescription.topAnchor.constraint(equalTo: greetings.bottomAnchor, constant: 8),
                greetingsDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                greetingsDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                greetingsDescription.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            ])
        }
    }
}
