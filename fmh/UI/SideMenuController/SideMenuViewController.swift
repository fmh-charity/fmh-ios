//
//  SideMenuViewController.swift
//  fmh
//
//  Created: 11.12.2022
//

import UIKit

protocol SideMenuViewControllerDelegate: AnyObject {
    func didSelect(itemMenu: SideMenuItems)
}

// MARK: - SideMenuViewController

private enum Constant {
    static let backgroundColor = UIColor.secondarySystemBackground
    static let wrapperTableViewBackgroundColor = UIColor.systemBackground
}

final class SideMenuViewController: UIViewController {

    weak var delegate: SideMenuViewControllerDelegate?
    
    // MARK: - Public vars
    
    var isHighlightedCellOff: Bool = false
    
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
            topView.model = .init(title: "\(profileUser.lastName) \(profileUser.firstName)",
                                  subtitle:  profileUser.isAdmin ? "Aдминистратор" : "")
        }
    }
    
    // MARK: - Private vars
    
    enum Section: Int { case general = 0, secondary, settings }
    
    // TODO:  В зависимости кто авторизован отображаем пункты меню или просто деактивируем !!!
    
    private lazy var sections: [Section : [SideMenuItems]] = {
        [
            .general : [.home, .news, .claim, .wishes, .chambers, .patients],
            .secondary : [.documents, .scheduleDuty, .staff, .ourMission],
            .settings : [.instructions, .aboutHospice, .aboutApp]
        ]
    }() { didSet { updateData() } }
    
    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.bounces = true
        tableView.estimatedSectionHeaderHeight = 0
        tableView.showsVerticalScrollIndicator = false
        tableView.showsHorizontalScrollIndicator = false
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SideMenuTableViewCell.self, forCellReuseIdentifier: SideMenuTableViewCell.identifier)
        
        return tableView
    }()
    
    private lazy var topView: SideMenuTopView = {
        let view = SideMenuTopView()
        view.logoutDidTap = { [weak self] in
            self?.delegate?.didSelect(itemMenu: .logout)
        }
        return view
    }()
    
    private lazy var wrapperTableView: UIView = {
        let view = UIView()
        view.backgroundColor = Constant.wrapperTableViewBackgroundColor
        view.layer.cornerRadius = 12
        return view
    }()
    
    private lazy var appVersionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 11)
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "App version: " + (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "?")
        return label
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constant.backgroundColor
        setupUI()
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        
        wrapperTableView.addSubviews(tableView) {[
            tableView.topAnchor.constraint(equalTo: wrapperTableView.topAnchor, constant: 8),
            tableView.leadingAnchor.constraint(equalTo: wrapperTableView.leadingAnchor, constant: 8),
            tableView.trailingAnchor.constraint(equalTo: wrapperTableView.trailingAnchor, constant: -8),
            tableView.bottomAnchor.constraint(equalTo: wrapperTableView.bottomAnchor, constant: -8)
        ]}
        
        view.addSubviews(topView, wrapperTableView, appVersionLabel) {[
            topView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            topView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            wrapperTableView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 8),
            wrapperTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            wrapperTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            
            appVersionLabel.topAnchor.constraint(equalTo: wrapperTableView.bottomAnchor, constant: 8),
            appVersionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            appVersionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            appVersionLabel.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)
        ]}
    }
    
    // MARK: - Private Logic
    
    private func updateData() {
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .systemBackground
        return view
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
        let nonSelectsMenu: [SideMenuItems] = []
        
        if let section = Section(rawValue: indexPath.section), let itemMenu = sections[section]?[indexPath.row] {
            guard !nonSelectsMenu.contains(itemMenu) else { return }
            self.delegate?.didSelect(itemMenu: itemMenu)
        }
    }
}
