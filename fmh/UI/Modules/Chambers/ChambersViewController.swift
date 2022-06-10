//
//  ChambersViewController.swift
//  fmh
//
//  Created: 09.06.2022
//

import UIKit

class ChambersViewController: UIViewController, ChambersViewControllerProtocol {
    
    var onCompletion: (() -> ())?
    
    let roomView = ChambersHeaderListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(roomView)
        setupBackground()
        setupConstrains()
    }
    
    private func setupBackground() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "BackGround") ?? UIImage())
    }
    
    private func setupConstrains() {
        
        NSLayoutConstraint.activate([
            roomView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            roomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            roomView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        
    }
    
}

// MARK: - SwiftUI Canvas

import SwiftUI

struct ViewControllerProvider: PreviewProvider {
    
    static var previews: some View {
        ContainerView().edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = ChambersViewController()
        
        func makeUIViewController(context: Context) -> some UIViewController {
            viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        }
    }
}
