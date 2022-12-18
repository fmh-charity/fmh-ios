//
//  SideMenuViewController.swift
//  fmh
//
//  Created: 11.12.2022
//

import Foundation
import UIKit


protocol SideMenuViewControllerDelegate: AnyObject {
    func didSelect(itemMenu: SideMenuItems)
}


class SideMenuViewController: UIViewController {
    
    weak var delegate: SideMenuViewControllerDelegate?
    
    enum Section: Int { case general = 0, secondary, settings }
    
    // В зависимости кто авторизован отображаем пункты меню или просто деактивируем !!!

    // TODO: Содержимое бокового меню
    private lazy var sections: [Section : [SideMenuItems]] = {
        [
            .general : [.home], // [.home, .news, .claim, .wishes, .chambers, .patients],
            .secondary : [], //[.documents, .scheduleDuty, .staff, .ourMission],
            .settings : [], //[.instructions, .aboutHospis, .aboutApp]
        ]
    }() { didSet { updeteData() } } // <- На всякий малоли из вне изменять.
    
    var isHighlightedCellOff: Bool = false
    
    // Выделение пункта меню
    var defaultHighlightedMenu: SideMenuItems = .home {
        didSet {
            guard !isHighlightedCellOff else { return }
            sections.enumerated().forEach { id, element in
                let id = element.value.enumerated().first(where: { $0.element.kind == defaultHighlightedMenu.kind })?.offset
                if let id = id {
                    let defaultRow = IndexPath(row: id, section: element.key.rawValue)
                    self.tableView.selectRow(at: defaultRow, animated: true, scrollPosition: .none)
                }
            }
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
            self?.delegate?.didSelect(itemMenu: .logout)
        }
        view.profileDidTap = { [weak self] in
            self?.delegate?.didSelect(itemMenu: .profile)
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
            topView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: -44),
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = Section(rawValue: section), section != .general else { return 0 }
        return 16
    }
    
}

// MARK: - UITableViewDataSource
extension SideMenuViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { return 0 }
        return sections[section]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuTableViewCell.identifier, for: indexPath)
        guard let cell = cell as? SideMenuTableViewCell else { fatalError("Cell doesn't exist") }
        
        if let section = Section(rawValue: indexPath.section), let itemMenu = sections[section]?[indexPath.row] {
            // Без выделения ячейки
            if isHighlightedCellOff {
                cell.selectionStyle = .none
            } else {
                if [].contains(itemMenu) { cell.selectionStyle = .none }
            }
            cell.model = .init(img: itemMenu.image, title: itemMenu.title)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Не кликабелины (отключенные) ...
        let nonSelectsMenu: [SideMenuItems] = []
        
        if let section = Section(rawValue: indexPath.section), let itemMenu = sections[section]?[indexPath.row] {
            guard !nonSelectsMenu.contains(itemMenu) else { return }
            self.delegate?.didSelect(itemMenu: itemMenu)
        }
    }
    
}

