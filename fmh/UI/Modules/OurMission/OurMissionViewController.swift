//
//  OurMissionViewController.swift
//  fmh
//
//  Created: 5/15/22
//

import UIKit

class OurMissionViewController: UIViewController {

    private let taglineView = UIView()
    private let tableView = UITableView()
    
    override func loadView() {
        super.loadView()
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(OurMissionCell.self, forCellReuseIdentifier: OurMissionCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    // MARK: - Setup UI
    private func setupUI() {
        view.backgroundColor = .white //delete
        view.addSubview(taglineView)
        taglineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            taglineView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60), //fix
            taglineView.leftAnchor.constraint(equalTo: view.leftAnchor),
            taglineView.rightAnchor.constraint(equalTo: view.rightAnchor),
            taglineView.heightAnchor.constraint(equalToConstant: 68)
        ])
        taglineView.clipsToBounds = true
        taglineView.backgroundColor = UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1)
        
        let taglineLabel = UILabel()
        taglineView.addSubview(taglineLabel)
        taglineLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            taglineLabel.centerXAnchor.constraint(equalTo: taglineView.centerXAnchor),
            taglineLabel.centerYAnchor.constraint(equalTo: taglineView.centerYAnchor),
            taglineLabel.heightAnchor.constraint(equalToConstant: 32),
            taglineLabel.widthAnchor.constraint(equalToConstant: 211)
        ])
        taglineLabel.clipsToBounds = true
        taglineLabel.layer.cornerRadius = 6
        taglineLabel.backgroundColor = UIColor(red: 0.821, green: 1, blue: 0.998, alpha: 1)
        taglineLabel.font.withSize(19   )
        taglineLabel.textColor = UIColor(red: 0, green: 0.506, blue: 0.498, alpha: 1)
        taglineLabel.textAlignment = .center
        taglineLabel.text = "Главное - жить любя"
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.topAnchor.constraint(equalTo: taglineView.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.clipsToBounds = true
        tableView.backgroundView = UIImageView(image: UIImage(named: "BackGround"))
        tableView.separatorStyle = .none
    }

}
