//
//  ProfileViewController.swift
//  fmh
//
//  Created: 17.12.2022
//

import Foundation

final class ProfileViewController: ViewController {
    
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
