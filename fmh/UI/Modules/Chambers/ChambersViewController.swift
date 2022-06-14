//
//  ChambersViewController.swift
//  fmh
//
//  Created: 09.06.2022
//

import UIKit

class ChambersViewController: UIViewController, ChambersViewControllerProtocol {
    
    var onCompletion: (() -> ())?
    
    let headerPanel = ChambersHeaderListView()
    let chambers = ChamberModel.chambers
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChamberTableViewCell.self, forCellReuseIdentifier: ChamberTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupBackground()
        setupConstrains()
    }
    
    private func setupBackground() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "BackGround") ?? UIImage())
    }
    
    private func addSubviews() {
        view.addSubview(headerPanel)
        view.addSubview(tableView)
    }
    
    private func setupConstrains() {
        
        NSLayoutConstraint.activate([
            headerPanel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerPanel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerPanel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headerPanel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

// MARK: - TableViewDelegate and TableViewDataSource

extension ChambersViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        chambers.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChamberTableViewCell.identifier, for: indexPath) as? ChamberTableViewCell else { return UITableViewCell() }
        
        let chamber = chambers[indexPath.section]
        
        switch indexPath.row {
        case 0:
            cell.configure(with: .numberOfChamber, and: chamber.numberOfChamber)
        case 1:
            cell.configure(with: .post, and: chamber.post)
        case 2:
            cell.configure(with: .block, and: chamber.block)
        case 3:
            cell.configure(with: .freePlaces, and: chamber.freePlaces)
        default:
            cell.configure(with: .comment, and: chamber.comment)
        }
        
        if indexPath.row == 0
            {
            cell.backgroundColor = UIColor(named: "peach")
            } else {
                cell.backgroundColor = .white
            }
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = CGColor(gray: 0.75, alpha: 1)
        
        return cell
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
