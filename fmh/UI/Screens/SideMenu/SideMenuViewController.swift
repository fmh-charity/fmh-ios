//
//  SideMenuViewController.swift
//  fmh
//
//  Created: 11.12.2022
//

import Foundation
import UIKit


protocol SideMenuViewControllerDelegate {
    func didSelect(indexPath: IndexPath)
}


class SideMenuViewController: UIViewController {
    
    var itemsMenu: [SideMenu] = [.home, .news]
    var itemsAdditionalMenu: [SideMenu.AdditionalMenu] = [.user, .logOut]
    
    var delegate: SideMenuViewControllerDelegate?
    
    var defaultHighlightedCell: Int = 0 {
        didSet {
            let defaultRow = IndexPath(row: self.defaultHighlightedCell, section: 0)
            self.tableView.selectRow(at: defaultRow, animated: true, scrollPosition: .none)
        }
    }
    
    var shortUserName: String? = nil {
        didSet {
            let indexPathUser = IndexPath(row: 0, section: 1)
            self.tableView.reloadRows(at: [indexPathUser], with: .none)
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.bounces = false
        tableView.estimatedSectionHeaderHeight = 0
        
        tableView.register(SideMenuTableViewCell.self, forCellReuseIdentifier: SideMenuTableViewCell.identifier)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .accentColor
        self.tableView.delegate = self
        self.tableView.dataSource = self
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        defaultHighlightedCell = 0
    }
    
    private func configure() {
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            tableView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
        self.tableView.reloadData()
    }
    
}

// MARK: - UITableViewDelegate
extension SideMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

// MARK: - UITableViewDataSource
extension SideMenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        section == 0 ? 0 : 0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        section == 0 ? nil : nil
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? itemsMenu.count : itemsAdditionalMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuTableViewCell.identifier, for: indexPath)
        guard let cell = cell as? SideMenuTableViewCell else { fatalError("Cell doesn't exist") }
  
        if indexPath.section == 0 {
            let itemMenu = itemsMenu[indexPath.row]
            // Без выделения ячейки
            if [].contains(itemMenu) { cell.selectionStyle = .none }
            
            cell.configure(
                image: itemMenu.image,
                title: itemMenu.title
            )
        }
        
        if indexPath.section == 1 {
            let itemMenu = itemsAdditionalMenu[indexPath.row]
            // Без выделения ячейки
            if [].contains(itemMenu) { cell.selectionStyle = .none }
            
            if itemMenu == .user {
                cell.configure(
                    image: itemMenu.image,
                    title: shortUserName ?? itemMenu.title
                )
            } else {
                cell.configure(
                    image: itemMenu.image,
                    title: itemMenu.title
                )
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Не кликабелины (отключенные) ...
        let nonSelectsMenu: [SideMenu] = []
        let nonSelectsAdditionalMenu: [SideMenu.AdditionalMenu] = [.user]

        if indexPath.section == 0 {
            let itemMenu = itemsMenu[indexPath.row]
            guard !nonSelectsMenu.contains(itemMenu) else { return }
        }

        if indexPath.section == 1 {
            let itemMenu = itemsAdditionalMenu[indexPath.row]
            guard !nonSelectsAdditionalMenu.contains(itemMenu) else { return }
        }

        self.delegate?.didSelect(indexPath: indexPath)
    }
    
}

