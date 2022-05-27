//
//  SideMenuViewController.swift
//  fmh
//
//  Created: 21.05.2022
//

import Foundation
import UIKit

protocol SideMenuViewControllerDelegate {
    func didSelect(indexPath: IndexPath)
}

class SideMenuViewController: UIViewController {
    
    private typealias Menu = GeneralMenu
    private typealias AdditionalMenu = GeneralMenu.AdditionalMenu
    
    var delegate: SideMenuViewControllerDelegate?
    var defaultHighlightedCell: Int = 0
    
    var shortUserName: String = "" {
        didSet {
            self.menuTableView.reloadData()
        }
    }

    private var logoView: UIView = {
        let view = UIView()
        let imageLogo = UIImageView()
        imageLogo.image = UIImage(named: "logo")
        imageLogo.contentMode = .scaleAspectFit
        
        view.addSubview(imageLogo)
        imageLogo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageLogo.topAnchor.constraint(equalTo: view.topAnchor),
            imageLogo.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageLogo.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            imageLogo.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        let contextView = UIView()
        contextView.addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: contextView.topAnchor),
            view.leadingAnchor.constraint(equalTo: contextView.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: contextView.trailingAnchor),
            view.heightAnchor.constraint(equalToConstant: 45)
        ])
        
        return contextView
    }()
    
    private var menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        tableView.register(GeneralMenuItemCell.self, forCellReuseIdentifier: GeneralMenuItemCell.identifier)
        
        return tableView
    }()
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .accentColor
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
        setupLayouts()
        
        // Set Highlighted Cell
       DispatchQueue.main.async {
           let defaultRow = IndexPath(row: self.defaultHighlightedCell, section: 0)
           self.menuTableView.selectRow(at: defaultRow, animated: false, scrollPosition: .none)
       }
        
        self.menuTableView.reloadData()
    }
    
    // MARK: - Private methods
    private func setupLayouts() {
        
        let margins = self.view.layoutMarginsGuide
        
        self.view.addSubview(menuTableView)
        menuTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuTableView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0),
            menuTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            menuTableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 0),
            menuTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
        
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
        switch section {
            case 0:
                return 80
            case 1:
                return 0
            default:
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
            case 0:
                return logoView
            case 1:
                return nil
            default:
                return nil
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        section == 0 ? Menu.allCases.count : AdditionalMenu.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GeneralMenuItemCell.identifier, for: indexPath) as? GeneralMenuItemCell else { fatalError("Cell doesn't exist") }
        if indexPath.section == 0 {
            let itemMenu = Menu.allCases[indexPath.row]
            cell.configure(
                image: itemMenu.image,
                title: itemMenu.rawValue
            )
        }
        if indexPath.section == 1 {
            let itemMenu = AdditionalMenu.allCases[indexPath.row]
            if itemMenu == .user {
                cell.configure(
                    image: itemMenu.image,
                    title: shortUserName
                )
            } else {
                cell.configure(
                    image: itemMenu.image,
                    title: itemMenu.rawValue
                )
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelect(indexPath: indexPath)
        
        if indexPath.section == 1 {
            let itemMenu = AdditionalMenu.allCases[indexPath.row]
            if itemMenu == .logOut {
                tableView.deselectRow(at: indexPath, animated: true)
            }
        }
    }
    
}
