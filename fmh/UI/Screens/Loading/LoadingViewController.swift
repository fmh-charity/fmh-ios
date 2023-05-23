//
//  LoadingViewController.swift
//  fmh
//
//  Created: 26.11.2022
//

import Foundation
import UIKit

protocol LoadingViewControllerProtocol: BaseViewController {
    func loadingServiceCompletion(error: Error?)
}

final class LoadingViewController: BaseViewController {
    
    // Когда все сервисы завершились без ошибок.
    private var isLoadingServiceCompletionOk: Bool = false

    private var timer: Timer?
    
    private lazy var content: Content = {
        let content = Content()
        return content
    }()
    
    private var countShows: Int = 0 {
        didSet {
            if isLoadingServiceCompletionOk && countShows > 0 {
                self.deleteTimer()
                self.onCompletion?()
            }
            if countShows > 6 { // Если больше 60 сек
                let errorStr = "При загрузке приложения произошла ошибка.\nПопробуйте перезагрузить приложение!"
                self.showAlert(title: "Ошибка", message: errorStr)
                self.deleteTimer()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateContent()
    }
    
    private func configure() {
        view.backgroundColor = .white
        createTimer()
        setLayouts()
    }
    
    private func createTimer() {
        guard timer == nil else { return }
        // 10 сек нужно ...
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
        timer.tolerance = 0.1
        
        self.timer = timer
    }
    
    private func deleteTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func updateTimer() {
        countShows += 1
        updateContent()
    }
    
    private func setLayouts() {
        view.addSubview(content)
        NSLayoutConstraint.activate([
            content.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            content.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func updateContent() {
        let model = data.randomElement()
        guard let model = model else { return }
        content.model = .init(color: model.accentColor, imgNme: model.imgName, discription: model.description)
    }
}

// MARK: UI - Content

fileprivate extension LoadingViewController {
    
    class Content: UIView {
        
        var model: Model? {
            didSet {
                guard let model = model else { return }
                
                img.image = UIImage(named: model.imgNme)
                discriptions.text = model.discription
                
                activityIndicator.color = model.color
                discriptionsWrapper.backgroundColor = model.color
                
                activityIndicator.startAnimating()
            }
        }
        
        private lazy var img: UIImageView = {
            let imgView = UIImageView()
            imgView.translatesAutoresizingMaskIntoConstraints = false
            imgView.backgroundColor = .clear
            imgView.contentMode = .scaleAspectFill
            return imgView
        }()
        
        private lazy var activityIndicator : UIActivityIndicatorView = {
            let indicator = UIActivityIndicatorView(style: .large)
            indicator.translatesAutoresizingMaskIntoConstraints = false
            indicator.backgroundColor = .clear
            return indicator
        }()
        
        private lazy var discriptions: UILabel = {
            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.textAlignment = .center
            label.lineBreakMode = .byWordWrapping
            label.adjustsFontSizeToFitWidth = true
            label.minimumScaleFactor = 12
            label.textColor = .black
            label.font = UIFont(name: "SFNSDisplay-Regular", size: 16)
            return label
        }()
        
        private lazy var discriptionsWrapper: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            view.backgroundColor = .clear
            view.layer.cornerRadius = 8
            view.layer.masksToBounds = true
            
            view.addSubview(discriptions)
            NSLayoutConstraint.activate([
                discriptions.topAnchor.constraint(equalTo: view.topAnchor, constant: 8),
                discriptions.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
                discriptions.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
                discriptions.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8)
            ])
            return view
        }()
        
        override init(frame: CGRect) {
            super.init(frame: .zero)
            self.translatesAutoresizingMaskIntoConstraints = false
            self.backgroundColor = .white
            setupLayuots()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        func setupLayuots() {
            
            self.addSubviews(img, activityIndicator, discriptionsWrapper) {[
                img.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 16),
                img.leadingAnchor.constraint(equalTo: leadingAnchor),
                img.trailingAnchor.constraint(equalTo: trailingAnchor),
                
                activityIndicator.topAnchor.constraint(equalTo: img.bottomAnchor, constant: 0),
                activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
                
                discriptionsWrapper.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 32),
                discriptionsWrapper.centerXAnchor.constraint(equalTo: centerXAnchor),
                discriptionsWrapper.bottomAnchor.constraint(equalTo: bottomAnchor),
            ]}
        }
        
        struct Model {
            var color: UIColor
            var imgNme: String
            var discription: String
        }
        
    }
}

// MARK: - LoadingViewControllerProtocol

extension LoadingViewController: LoadingViewControllerProtocol {
    
    func loadingServiceCompletion(error: Error?) {
        guard let _ = error else { self.isLoadingServiceCompletionOk = true; return }
        let errorStr = "При загрузке приложения произошла ошибка.\nПопробуйте перезагрузить приложение!"
        self.showAlert(title: "Ошибка", message: errorStr)
        self.deleteTimer()
    }
}
