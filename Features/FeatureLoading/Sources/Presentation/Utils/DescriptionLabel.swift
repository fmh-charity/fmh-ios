//
//  DescriptionLabel.swift
//  
//
//  Created by Константин Туголуков on 06.08.2023.
//

import UIKit

class DescriptionLabel: UILabel {
    
    private let edgeInsets: UIEdgeInsets = .init(top: 10, left: 10, bottom: 10, right: 10)
    
    open override func textRect(forBounds bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
        let insetRect = bounds.inset(by: edgeInsets)
        let textRect = super.textRect(forBounds: insetRect, limitedToNumberOfLines: numberOfLines)
        let invertedInsets = UIEdgeInsets(top: -edgeInsets.top, left: -edgeInsets.left, bottom: -edgeInsets.bottom, right: -edgeInsets.right)
        return textRect.inset(by: invertedInsets)
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: edgeInsets))
    }
}
