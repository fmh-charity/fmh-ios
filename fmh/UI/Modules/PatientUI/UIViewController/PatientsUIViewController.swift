//
//  PatientsUIViewController.swift
//  fmh
//
//  Created: 28.05.2022
//

import UIKit

final class PatientsUIViewController: UIViewController {
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Поиск"
        searchBar.barTintColor = UIColor.systemGray5
        searchBar.searchTextField.backgroundColor = .white
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        return searchBar
    }()
    
    private let buttonPanel = PatientsUIView()
    
    private let stackView: UIStackView = {
        let stack = UIStackView(frame: .zero)
        stack.axis = .vertical
        stack.spacing = 17
        stack.alignment = .fill
        stack.backgroundColor = UIColor.systemGray5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var generalInfoTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PatientTableViewCell.self, forCellReuseIdentifier: PatientTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        setUpConstraints()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "BackGround") ?? UIImage())
    }
    
    func setUpConstraints() {
        
        view.addSubview(stackView)
        view.addSubview(generalInfoTableView)
        stackView.addArrangedSubview(buttonPanel)
        stackView.addArrangedSubview(searchBar)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -675),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            searchBar.leadingAnchor.constraint(equalTo: stackView.leadingAnchor, constant: 15),
            searchBar.trailingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            generalInfoTableView.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            generalInfoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            generalInfoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            generalInfoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}


extension PatientsUIViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PatientTableViewCell.identifier, for: indexPath) as? PatientTableViewCell else { return UITableViewCell() }
        let patientModel = PatientModel.patients[indexPath.row]
        switch indexPath.row {
        case 0:
            cell.configure(descriptionTypes: .fio, patientInfo: patientModel.fio)
        case 1:
            cell.configure(descriptionTypes: .dateOfBirth, patientInfo: patientModel.dateOfBirth)
        case 2:
            cell.configure(descriptionTypes: .status, patientInfo:  patientModel.status)
        default:
            break
        }
        if (indexPath.row == 0)
            {
            cell.backgroundColor = UIColor(named: "peach")
            } else {
                cell.backgroundColor = .white
            }
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = CGColor(gray: 0.75, alpha: 1)
        return cell
    }
}
