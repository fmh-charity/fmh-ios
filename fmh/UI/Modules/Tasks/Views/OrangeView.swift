//
//  OrangeView.swift
//  fmh
//
//  Created: 27.05.22
//

import UIKit

class OrangeView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(named: "TaskCollectionViewHeaderColor")
        self.translatesAutoresizingMaskIntoConstraints = false
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
