//
//  ChambersViewController.swift
//  fmh
//
//  Created: 09.06.2022
//

import UIKit

class ChambersViewController: UIViewController, ChambersViewControllerProtocol {
    
    var onCompletion: (() -> ())?
    
    let headerPanel = HeaderMenuView(labelText: "Список палат", leftButtonImage: UIImage(systemName: "info.circle"), rightButtonImage: UIImage(systemName: "plus.circle"))
    let chambers = ChamberModel.chambers
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChambersTableViewCell.self, forCellReuseIdentifier: ChambersTableViewCell.identifier)
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
            headerPanel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerPanel.heightAnchor.constraint(equalToConstant: 56)
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
        chambers.count
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        chambers.count
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        300
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChambersTableViewCell.identifier, for: indexPath) as? ChambersTableViewCell else { return UITableViewCell() }
        
//        let chamber = chambers[indexPath.section]
        
        let chamber = chambers[indexPath.row]
        
        cell.configure(numberOfChamber: chamber.numberOfChamber,
                       chamber: chamber.chamber,
                       numberOfPost: chamber.numberOfPost,
                       post: chamber.post,
                       numberOfBlock: chamber.numberOfBlock,
                       block: chamber.block,
                       numberOfFreePlaces: chamber.numberOfFreePlaces,
                       freePlaces: chamber.freePlaces,
                       comment: chamber.comment,
                       nameOfComment: chamber.nameOfComment)
        
//        switch indexPath.row {
//        case 0:
//            cell.configure(with: .numberOfChamber, and: chamber.numberOfChamber, backgroundColor: UIColor(named: "peach"))
//        case 1:
//            cell.configure(with: .post, and: chamber.post, backgroundColor: .white)
//        case 2:
//            cell.configure(with: .block, and: chamber.block, backgroundColor: .white)
//        case 3:
//            cell.configure(with: .freePlaces, and: chamber.freePlaces, backgroundColor: .white)
//        default:
//            cell.configure(with: .comment, and: chamber.comment, backgroundColor: .white)
//        }
        
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
