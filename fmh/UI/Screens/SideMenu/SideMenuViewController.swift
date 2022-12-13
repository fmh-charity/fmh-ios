//
//  SideMenuViewController.swift
//  fmh
//
//  Created: 11.12.2022
//

import Foundation
import UIKit


protocol SideMenuViewControllerDelegate: AnyObject {
    func didSelect(itemMenu: SideMenu)
}


class SideMenuViewController: UIViewController {
    
    var itemsMenu: [SideMenu] = [.home, .news, .user, .logOut]
    
    weak var delegate: SideMenuViewControllerDelegate?
    
    var isHighlightedCellOff: Bool = true
    
    var defaultHighlightedCell: Int = 0 {
        didSet {
            guard !isHighlightedCellOff else { return }
            let defaultRow = IndexPath(row: self.defaultHighlightedCell, section: 0)
            self.tableView.selectRow(at: defaultRow, animated: true, scrollPosition: .none)
        }
    }
    
    var shortUserName: String? = nil {
        didSet {
            let indexPathUser = IndexPath(row: SideMenu.user.rawValue, section: 0)
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
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        
        tableView.register(SideMenuHeader.self, forHeaderFooterViewReuseIdentifier: SideMenuHeader.identifier)
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
        section == 0 ? 60 : 10
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: SideMenuHeader.identifier)
        guard let header = header as? SideMenuHeader else { return nil }
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemsMenu.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuTableViewCell.identifier, for: indexPath)
        guard let cell = cell as? SideMenuTableViewCell else { fatalError("Cell doesn't exist") }
  
        let itemMenu = itemsMenu[indexPath.row]
        
        // Без выделения ячейки
        if isHighlightedCellOff {
            cell.selectionStyle = .none
        } else {
            if [.user].contains(itemMenu) { cell.selectionStyle = .none }
        }
        
        cell.configure(
            image: itemMenu.image,
            title: itemMenu.title
        )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Не кликабелины (отключенные) ...
        let nonSelectsMenu: [SideMenu] = [.user]

        let itemMenu = itemsMenu[indexPath.row]
        guard !nonSelectsMenu.contains(itemMenu) else { return }

        self.delegate?.didSelect(itemMenu: itemMenu)
    }
    
}

