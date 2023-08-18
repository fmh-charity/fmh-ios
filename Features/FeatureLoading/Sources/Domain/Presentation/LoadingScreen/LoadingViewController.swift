//
//  LoadingViewController.swift
//  
//
//  Created: 29.07.2023
//

import Foundation
import UIKit

final class LoadingViewController: UIViewController {
    
    // Dependencies
    private let presenter: LoadingPresenterProtocol
    
    // MARK: - UI
    
    private lazy var imageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())
    
    private lazy var indicator: UIActivityIndicatorView = {
        $0.backgroundColor = .clear
        return $0
    }(UIActivityIndicatorView(style: .large))
    
    private lazy var descriptions: DescriptionLabel = {
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
        
        $0.adjustsFontSizeToFitWidth = true
        $0.minimumScaleFactor = 12
        $0.textColor = .black
        $0.font = UIFont(name: "SFNSDisplay-Regular", size: 16)
        
        return $0
    }(DescriptionLabel())
    
    private lazy var content: UIView = .init()
    
    // MARK: - init
    
    init(presenter: LoadingPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        presenter.viewDidLoad()
    }
    
    // MARK: - Configure
    
    private func configure() {
        view.backgroundColor = .white
        imageView.startAnimating()
        setupUI()
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        view.addSubviews(content) {[
            content.topAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor),
            content.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor),
            content.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            content.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]}
        
        content.addSubviews(imageView, indicator, descriptions) {[
            imageView.topAnchor.constraint(equalTo: content.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: content.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: content.trailingAnchor),
            
            indicator.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
            indicator.centerXAnchor.constraint(equalTo: content.centerXAnchor),
            
            descriptions.topAnchor.constraint(equalTo: indicator.bottomAnchor, constant: 32),
            descriptions.centerXAnchor.constraint(equalTo: content.centerXAnchor),
            descriptions.bottomAnchor.constraint(equalTo: content.bottomAnchor),
        ]}
    }
}

// MARK: - LoadingPresenterDelegate

extension LoadingViewController: LoadingPresenterDelegate {
    
    struct Model {
        let accentColor: UIColor
        let imageName: String
        let description: String
    }
    
    func configure(_ model: Model) {
        imageView.image = UIImage(named: model.imageName, in: .module, with: .none)
        
        descriptions.text = model.description
        descriptions.backgroundColor = model.accentColor
        
        indicator.color = model.accentColor
        indicator.startAnimating()
    }
}

// MARK: - DescriptionLabel

private final class DescriptionLabel: UILabel {
    
    private let edgeInsets: UIEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
    
    override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: edgeInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -edgeInsets.top, left: -edgeInsets.left, bottom: -edgeInsets.bottom, right: -edgeInsets.right)
        return textRect.inset(by: invertedInsets)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: edgeInsets))
    }
}
