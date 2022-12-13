//
//  SideMenuHeader.swift
//  fmh
//
//  Created: 13.12.2022
//

import UIKit


final class SideMenuHeader: UITableViewHeaderFooterView {
    
    class var identifier: String { return String(describing: self) }
    
    private lazy var imgView: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.backgroundColor = .clear
        imgView.contentMode = .scaleAspectFit
        return imgView
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        imgView.image = UIImage(named: "logo")
        
        contentView.addSubview(imgView)

        NSLayoutConstraint.activate([
            imgView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imgView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imgView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
    }
    
    override func prepareForReuse() {
        
    }
    
}
