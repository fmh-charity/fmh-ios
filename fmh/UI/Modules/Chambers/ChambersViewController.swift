//
//  ChambersViewController.swift
//  fmh
//
//  Created: 09.06.2022
//

import UIKit

class ChambersViewController: UIViewController, ChambersViewControllerProtocol {
    
    // MARK: - Public properties
    
    var onCompletion: (() -> ())?
    
    let headerMenu = HeaderMenuView(labelText: "Список палат", leftButtonImage: UIImage(systemName: "info.circle"), rightButtonImage: UIImage(systemName: "plus.circle"))
    let chambers = ChamberModel.chambers
    
    // MARK: - Private properties
    
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
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupBackground()
        setupConstrains()
    }
    
    // MARK: - Private methods
    
    private func setupBackground() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "BackGround") ?? UIImage())
    }
    
    private func addSubviews() {
        view.addSubview(headerMenu)
        view.addSubview(tableView)
    }
    
}

// MARK: - Setup constraints

extension ChambersViewController {
    
    private func setupConstrains() {
        
        NSLayoutConstraint.activate([
            headerMenu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerMenu.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headerMenu.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

// MARK: - TableViewDelegate and TableViewDataSource

extension ChambersViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    // сделано через секции, чтобы было расстояние между ячейками с помощью heightForHeaderInSection
    
    func numberOfSections(in tableView: UITableView) -> Int {
        chambers.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = ChamberViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .coverVertical
        vc.chamber = chambers[indexPath.section]
        present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChambersTableViewCell.identifier, for: indexPath) as? ChambersTableViewCell else { return UITableViewCell() }
                
        let chamber = chambers[indexPath.section]
        
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
