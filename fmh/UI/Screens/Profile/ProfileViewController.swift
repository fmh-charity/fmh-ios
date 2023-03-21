//
//  ProfileViewController.swift
//  fmh
//
//  Created: 17.12.2022
//

import Foundation

protocol ProfileViewControllerProtocol: ViewControllerProtocol {
    
}


final class ProfileViewController: ViewController, ProfileViewControllerProtocol {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Профайл"
        configure()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // ...
    }
    
    private func configure() {
       
    }
    
}
