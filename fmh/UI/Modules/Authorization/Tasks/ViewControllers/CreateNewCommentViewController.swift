//
//  CreateNewCommentViewController.swift
//  fmh
//
//  Created: 8.06.22
//

import UIKit

final class CreateNewCommentViewController: UIViewController {
    private let createComment = CreateEditCommentView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConstraint()
        view.backgroundColor = .white
    }
    
    func setUpConstraint(){
        view.addSubview(createComment)
        let constraints = [
            createComment.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            createComment.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            createComment.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            createComment.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -150),
            createComment.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/4),
            
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
