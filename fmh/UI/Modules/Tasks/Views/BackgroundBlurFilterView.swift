//
//  BackgroundBlurFilterView.swift
//  fmh
//
//  Created: 10.06.22
//

import UIKit

final class BackgroundBlurFilterView: UIView {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.alpha = 0.7
        blurEffectView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(blurEffectView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
