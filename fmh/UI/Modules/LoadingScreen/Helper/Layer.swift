//
//  Layer.swift
//  fmh
//
//  Created: 07.07.2022
//

import UIKit

final class Layer: UIView {

    //MARK: Properties
    
    private let presenter = Presenter()
    private var testData: [LoadingScreenModel] = []
    private weak var viewOutputDelegate: ViewOutputDelegate?
    private var count = Int.random(in: 0...16)
    
    //MARK: Life Cicle
    
    override init(frame: CGRect) {
            super.init(frame: frame)
        
        presenter.setViewInputDelegate(viewInputDelegate: self)
        self.viewOutputDelegate = presenter
        self.viewOutputDelegate?.getData()
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
       // fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Create UI elements
    
    //Background image
    private let backgroundImage: UIImageView = {
       let backgroundImage = UIImageView()
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.contentMode = .scaleAspectFill
        return backgroundImage
    }()
    
    // UIView for background image
    private let viewForBackgroundImage: UIView = {
       let viewForImage = UIView()
        viewForImage.translatesAutoresizingMaskIntoConstraints = false
        return viewForImage
    }()
    
    private var activityIndicator : UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.isHidden = false
        return activityIndicator
    }()
    
    // UIView for label
    private var viewForLabel : UIView = {
        let viewForLabel = UIView()
        viewForLabel.translatesAutoresizingMaskIntoConstraints = false
        viewForLabel.layer.cornerRadius = 10
        return viewForLabel
    }()
    
    //TextLabel
    private let textLbl: UILabel = {
        let textLbl = UILabel()
        textLbl.translatesAutoresizingMaskIntoConstraints = false
        textLbl.numberOfLines = 0
        textLbl.adjustsFontSizeToFitWidth = true
        textLbl.minimumScaleFactor = 0.5
        textLbl.textAlignment = .center
        return textLbl
    }()
    
    func setupLayout() {

         // View for background image
         addSubview(viewForBackgroundImage)
         NSLayoutConstraint.activate([
         viewForBackgroundImage.topAnchor.constraint(equalTo: topAnchor, constant: 100),
         viewForBackgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
         viewForBackgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
         viewForBackgroundImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/3)
         ])
         
         // BackgroundImage
         self.viewForBackgroundImage.addSubview(backgroundImage)
         NSLayoutConstraint.activate([
         backgroundImage.topAnchor.constraint(equalTo: viewForBackgroundImage.topAnchor),
         backgroundImage.leadingAnchor.constraint(equalTo: viewForBackgroundImage.leadingAnchor),
         backgroundImage.trailingAnchor.constraint(equalTo: viewForBackgroundImage.trailingAnchor),
         backgroundImage.bottomAnchor.constraint(equalTo: viewForBackgroundImage.bottomAnchor)
         ])
         
         addSubview(activityIndicator)
         NSLayoutConstraint.activate([
         activityIndicator.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: 50),
         activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor)
         ])
         
         // TextLabel
         self.viewForLabel.addSubview(textLbl)
         NSLayoutConstraint.activate([
         textLbl.topAnchor.constraint(equalTo: viewForLabel.topAnchor, constant: 10),
         textLbl.leadingAnchor.constraint(equalTo: viewForLabel.leadingAnchor, constant: 10),
         textLbl.trailingAnchor.constraint(equalTo: viewForLabel.trailingAnchor, constant: -10),
         textLbl.bottomAnchor.constraint(equalTo: viewForLabel.bottomAnchor, constant: -20)
         ])
         }
    }

extension Layer { // Нужно заменить на адаптивную верстку
    
    func constraintForLabel(viewHeight: CGFloat) {
        // UIView for label
        self.addSubview(viewForLabel)
        switch viewHeight {
        case 548.0...568.0: //iPhone 5S,SE
            NSLayoutConstraint.activate([
                viewForLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
                viewForLabel.heightAnchor.constraint(equalToConstant: 100),
                viewForLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2),
                viewForLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            ])
        case 647.0...667.0: //iPhone 6,7,8
            NSLayoutConstraint.activate([
                viewForLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -70),
                viewForLabel.heightAnchor.constraint(equalToConstant: 100),
                viewForLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2),
                viewForLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            ])
        case 716.0...1896.0: //iPhone 6+,7+,8+,X,XS,XR, XS_Max ...
            NSLayoutConstraint.activate([
                viewForLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -150),
                viewForLabel.heightAnchor.constraint(equalToConstant: 100),
                viewForLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1/2),
                viewForLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            ])
        default: print("В стэке нет размера экрана этого устройства!")
        }
    }
}

extension Layer: ViewInputDelegate {
    
    func setupInitialState() {
        displayData(i: count)
    }
    
    func setupData(with testData: ([LoadingScreenModel])) {
        self.testData = testData
    }
    
    func displayData(i: Int) {
        if testData.count >= 0 && count <= (testData.count - 1) && count >= 0 {
            textLbl.text = testData[i].textDescription
            viewForLabel.backgroundColor = testData[i].color
            activityIndicator.color = testData[i].color
            if let image = UIImage.init(named: testData[i].backgroundImage) {
                backgroundImage.image = image
            }
        } else {
            print("В модели нет данных или они не получены!")
        }
    }
}
