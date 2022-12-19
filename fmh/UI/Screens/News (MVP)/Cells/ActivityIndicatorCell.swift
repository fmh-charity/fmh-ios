//
//  ActivityIndikatorCell.swift
//  fmh
//
//  Created: 27.11.2022
//

import UIKit

class ActivityIndicatorCell: UICollectionViewCell {
    
    var activityIndicator: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        return activity
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureCell()
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        contentView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 40),
            activityIndicator.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
}
