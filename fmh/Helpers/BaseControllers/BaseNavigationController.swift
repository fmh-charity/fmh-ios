//
//  BaseNavigationController.swift
//  fmh
//
//  Created: 11.12.2022
//

import UIKit

class BaseNavigationController: UINavigationController {
    
    var onCompletion: (() -> Void)?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
        let app = UINavigationBarAppearance()
        app.titleTextAttributes = [.foregroundColor: UIColor.white]
        app.backgroundColor = .accentColor
        
        self.navigationBar.tintColor = .white
        self.navigationBar.compactAppearance = app
        self.navigationBar.standardAppearance = app
        self.navigationBar.scrollEdgeAppearance = app
    }
    
    override var childForStatusBarHidden: UIViewController? {
        topViewController
    }

    override var childForStatusBarStyle: UIViewController? {
        topViewController
    }
}
