//
//  ExampleFooter.swift
//  fmh
//
//  Created: 30.05.2022
//

import UIKit

class ExampleFooter: UICollectionReusableView {
    
    struct Model {
        
    }
    
    override func prepareForReuse() {

    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .black
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Model) {
    
    }
    
}
