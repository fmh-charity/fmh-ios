//
//  FMHUIRefreshControl.swift
//  fmh
//
//  Created: 02.09.2022
//

import UIKit

class FMHUIRefreshControl: UIRefreshControl {
    
    override init () {
        super.init()
//            let title = NSLocalizedString("Refreshing sensor data...", comment: "Pull to refresh")
//            attributedTitle = NSAttributedString(string: title)
        tintColor = .accentColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
