//
//  ProfileViewController.swift
//  fmh
//
//  Created: 17.12.2022
//

import UIKit

protocol ProfileViewControllerProtocol: BaseViewController {
    
}

final class ProfileViewController: BaseViewController, ProfileViewControllerProtocol {
    
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
