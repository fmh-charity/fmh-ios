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
    func logoutTap()
}


class SideMenuViewController: UIViewController {
    
    var itemsMenu: [SideMenu] = [] { // <- Устанавливается где используем контроллер (SideMenuNavigationController)
        didSet {
            updeteData()
        }
    }
    weak var delegate: SideMenuViewControllerDelegate?
    
    var isHighlightedCellOff: Bool = false
    
    var defaultHighlightedMenu: SideMenu = .home {
        didSet {
            guard !isHighlightedCellOff else { return }
            guard let id = itemsMenu.enumerated().first(where: { $0.element.kind == defaultHighlightedMenu.kind })?.offset else { return }
            let defaultRow = IndexPath(row: id, section: 0)
            self.tableView.selectRow(at: defaultRow, animated: true, scrollPosition: .none)
        }
    }
    
    var profileUser: APIClient.UserProfile? {
        didSet {
            guard let profileUser else { return }
            //            let f: String = profileUser.lastName
            //            let i = String(profileUser.firstName.first ?? " ")
            //            let o = String(profileUser.middleName.first ?? " ")
            self.bottomView.model = .init(.init(profileId: "ID: \(profileUser.id)",
                                                profileImg: UIImage(systemName: "person"),
                                                profileTitle: "\(profileUser.lastName) \(profileUser.firstName)",
                                                profileSubTitle: profileUser.isAdmin ? "Aдминистратор" : "")
            )
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
        
        tableView.register(SideMenuTableViewCell.self, forCellReuseIdentifier: SideMenuTableViewCell.identifier)
        
        return tableView
    }()
    
    private lazy var topView: SideMenuTopView = {
        let view = SideMenuTopView()
        return view
    }()
    
    private lazy var bottomView: SideMenuBottomView = {
        let view = SideMenuBottomView()
        view.logoutDidTap = { [weak self] in
            self?.delegate?.logoutTap()
        }
        view.profileDidTap = { [weak self] in
            // Show profile view
        }
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .accentColor
        self.tableView.delegate = self
        self.tableView.dataSource = self
        configure()
        updeteData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func configure() {
        self.view.addSubviews([topView, tableView, bottomView])
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 0),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 80),
            
            tableView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            bottomView.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 0),
            bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 0),
        ])
    }
    
    private func updeteData() {
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
        
        cell.model = .init(img: itemMenu.image, title: itemMenu.title)
        
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

