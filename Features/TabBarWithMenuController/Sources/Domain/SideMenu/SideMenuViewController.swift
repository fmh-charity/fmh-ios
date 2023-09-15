
import UIKit

protocol SideMenuViewControllerProtocol: UIViewController {
    func setTopViewModel(_ model: SideMenuTopView.Model)
}

// MARK: - SideMenuViewController

private enum Constant {
    static let backgroundColor = UIColor.secondarySystemBackground
    static let wrapperTableViewBackgroundColor = UIColor.systemBackground
}

final class SideMenuViewController: UIViewController, SideMenuViewControllerProtocol {
    
    // MARK: - Public vars
    
    var isHighlightedCellOff: Bool = false
    
    var defaultHighlightedMenu: SideMenuItem? = nil {
        didSet {
            guard !isHighlightedCellOff else { return }
            sections.enumerated().forEach { id, element in
                let id = element.value.enumerated().first(where: { $0.element.tag == defaultHighlightedMenu?.tag })?.offset
                if let id = id {
                    let defaultRow = IndexPath(row: id, section: element.key.rawValue)
                    self.tableView.selectRow(at: defaultRow, animated: true, scrollPosition: .none)
                }
            }
        }
    }
    
    var sections: [SideMenuSection : [SideMenuItem]] = [:] {
        didSet { updateData() }
    }
    
    // MARK: - Private
    
    private var topView: SideMenuTopView = SideMenuTopView()
    private var selectedMenuItem: SideMenuItem?
    
    // MARK: - UI
    
    private lazy var tableView: UITableView = {
        $0.separatorStyle = .none
        $0.bounces = true
        $0.estimatedSectionHeaderHeight = 0
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
        if #available(iOS 15.0, *) {
            $0.sectionHeaderTopPadding = 0
        }
        $0.delegate = self
        $0.dataSource = self
        $0.register(SideMenuTableViewCell.self, forCellReuseIdentifier: SideMenuTableViewCell.identifier)
        return $0
    }(UITableView(frame: .zero, style: .plain))
    
    private lazy var wrapperTableView: UIView = {
        $0.backgroundColor = Constant.wrapperTableViewBackgroundColor
        $0.layer.cornerRadius = 12
        return $0
    }(UIView())
    
    private lazy var appVersionLabel: UILabel = {
        $0.textColor = UIColor.lightGray
        $0.font = UIFont.systemFont(ofSize: 11)
        $0.textAlignment = .center
        $0.numberOfLines = 1
        $0.text = "App version: " + (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "?")
        return $0
    }(UILabel())
    
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
            topView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            topView.heightAnchor.constraint(equalToConstant: 80),
            
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
    
    // MARK: - SideMenuViewControllerProtocol
    
    func setTopViewModel(_ model: SideMenuTopView.Model) {
        topView.model = model
    }
}

// MARK: - UITableViewDelegate

extension SideMenuViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard let section = SideMenuSection(rawValue: section), section != .general else { return 0 }
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
        guard let section = SideMenuSection(rawValue: section) else { return 0 }
        return sections[section]?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SideMenuTableViewCell.identifier, for: indexPath)
        guard let cell = cell as? SideMenuTableViewCell else { fatalError("Cell doesn't exist") }
        
        if let section = SideMenuSection(rawValue: indexPath.section), let itemMenu = sections[section]?[indexPath.row] {
            if isHighlightedCellOff {
                cell.selectionStyle = .none
            } else {
                if [].contains(itemMenu.tag) { cell.selectionStyle = .none } // <- tags
            }
            cell.model = .init(img: itemMenu.image, title: itemMenu.title)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nonSelectsMenu: [String] = [selectedMenuItem?.tag ?? ""] // <- tags
        
        if let section = SideMenuSection(rawValue: indexPath.section), let itemMenu = sections[section]?[indexPath.row] {
            guard !nonSelectsMenu.contains(itemMenu.tag) else { return }
            itemMenu.didSelect?()
            selectedMenuItem = itemMenu
        }
    }
}
