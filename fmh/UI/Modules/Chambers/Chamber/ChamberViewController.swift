//
//  ChamberViewController.swift
//  fmh
//
//  Created: 01.07.2022
//

import UIKit

class ChamberViewController: UIViewController {
    
    let headerMenu = HeaderMenuView(labelText: "Палата", leftButtonImage: UIImage(systemName: "trash"), rightButtonImage: UIImage(systemName: "square.and.pencil"))
    
    var chamber: ChamberModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        setupBackground()
        print(chamber!)
    }
    
    private func setupBackground() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "BackGround") ?? UIImage())
    }
    
}

// MARK: - Setup constraints

extension ChamberViewController {
    
    private func addSubviews() {
        view.addSubview(headerMenu)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            headerMenu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerMenu.heightAnchor.constraint(equalToConstant: 56)
        ])
        
    }
    
}
