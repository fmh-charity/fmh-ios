//
//  NewsListControlPanel.swift
//  fmh
//
//  Created: 18.06.2022
//

import UIKit

class NewsListControlPanel: UIView {

    private(set) var title: UILabel = {
        let label = UILabel()
        label.text = "Новости"
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .topControl.title
        label.font = UIFont(name: "SFUIDisplay-Regular", size: 19)
        return label
    }()
    
    private(set) var sortButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "controlPanel.sorting")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .topControl.item
        return button
    }()
    
    private(set) var filterButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "controlPanel.filter")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .topControl.item
        button.isEnabled = false // <- Убрать потом
        return button
    }()
    
    private(set) var editButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "controlPanel.edit")?.withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = .topControl.item
        button.isEnabled = false // <- Убрать потом
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .topControl.backGround
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        self.addSubview(title)
        self.addSubview(sortButton)
        self.addSubview(filterButton)
        self.addSubview(editButton)
        self.addConstraintsWithFormat(format: "H:|-20-[v0]-20-[v1]-20-[v2]-20-[v3]-20-|", views: title, sortButton, filterButton, editButton)
        self.addConstraintsWithFormat(format: "V:|[v0]|", views: title)
        self.addConstraintsWithFormat(format: "V:|[v0]|", views: sortButton)
        self.addConstraintsWithFormat(format: "V:|[v0]|", views: filterButton)
        self.addConstraintsWithFormat(format: "V:|[v0]|", views: editButton)
    }
    
}
