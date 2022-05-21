//
//  GeneralMenuViewController.swift
//  fmh
//
//  Created: 21.05.2022
//

import Foundation
import UIKit

protocol GeneralMenuViewControllerDelegate {
    func didSelect(_ menuItem: GeneralMenuViewController.MenuOptions)
}

class GeneralMenuViewController: UIViewController {
    
    var delegate: GeneralMenuViewControllerDelegate?
    
    private var menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        tableView.register(GeneralMenuItemCell.self, forCellReuseIdentifier: GeneralMenuItemCell.identifier)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .accentColor
        
        self.menuTableView.delegate = self
        self.menuTableView.dataSource = self
        
        setupLayouts()
        
        self.menuTableView.reloadData()
    }
    
    private func setupLayouts() {
        
        let margins = self.view.layoutMarginsGuide
        
        self.view.addSubview(menuTableView)
        menuTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            menuTableView.topAnchor.constraint(equalTo: margins.topAnchor, constant: 0),
            menuTableView.leadingAnchor.constraint(equalTo: margins.leadingAnchor, constant: 0),
            menuTableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 0),
            menuTableView.trailingAnchor.constraint(equalTo: margins.trailingAnchor, constant: -100)
        ])
        
    }
    
}

// MARK: - UITableViewDelegate
extension GeneralMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

// MARK: - UITableViewDataSource
extension GeneralMenuViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
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
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        MenuOptions.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GeneralMenuItemCell.identifier, for: indexPath) as? GeneralMenuItemCell else { fatalError("Cell doesn't exist") }
        
        cell.iconImageView.image = MenuOptions.allCases[indexPath.row].image
        cell.titleLabel.text = MenuOptions.allCases[indexPath.row].rawValue
        
        // Highlighted color
        //        let myCustomSelectionColorView = UIView()
        //        myCustomSelectionColorView.backgroundColor = .green
        //        cell.selectedBackgroundView = myCustomSelectionColorView
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        let item = MenuOptions.allCases[indexPath.row]
        self.delegate?.didSelect(item)
        
        // Remove highlighted color when you press the 'Profile' and 'Like us on facebook' cell
        //        if indexPath.row == 4 || indexPath.row == 6 {
        //            tableView.deselectRow(at: indexPath, animated: true)
        //        }
        
    }
    
}
