//
//  EditTaskViewController.swift
//  fmh
//
//  Created: 03.06.2022
//

import UIKit

class EditTaskViewController: UIViewController {

    let customView = EditTaskView()

  
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.addSubview(customView)
       
        view.backgroundColor = .white
        setupElements()
       
    }

    func setupElements() {
        customView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        customView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        customView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        customView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150).isActive = true
        customView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
    }
}

