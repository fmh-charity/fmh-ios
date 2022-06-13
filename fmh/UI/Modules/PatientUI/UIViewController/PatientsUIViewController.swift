//
//  PatientsUIViewController.swift
//  fmh
//
//  Created: 28.05.2022
//

import UIKit

final class PatientsUIViewController: UIViewController {

    // MARK: - Private properties
    
    private let searchBar:UISearchBar = {
        let search = UISearchBar()
        search.placeholder = "Поиск"
        search.translatesAutoresizingMaskIntoConstraints = false
        search.barTintColor = .systemGray5
        search.searchTextField.backgroundColor = .white
        return search
    }()
    
    private var filteredPatients = [PatientModel]()
 
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
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        
        setUpConstraints()
        view.backgroundColor = UIColor(patternImage: UIImage(named: "BackGround") ?? UIImage())
        searchBar.delegate = self
        filteredPatients = patients
    }
    
    
  private func setUpConstraints() {
        
        view.addSubview(stackView)
        view.addSubview(generalInfoTableView)
        stackView.addArrangedSubview(buttonPanel)
        stackView.addArrangedSubview(searchBar)
      
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: generalInfoTableView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 125),
        ])
      
          NSLayoutConstraint.activate([
            generalInfoTableView.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            generalInfoTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            generalInfoTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            generalInfoTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}

// MARK: - * <- extensions

extension PatientsUIViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {

            return filteredPatients.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: PatientTableViewCell.identifier, for: indexPath) as? PatientTableViewCell else { return UITableViewCell() }
        var filter: PatientModel

        if (indexPath.row == 0)
            {
            cell.backgroundColor = UIColor(named: "peach")
            } else {
                cell.backgroundColor = .white
            }
        
            filter = filteredPatients[indexPath.section]
            filter = patients[indexPath.section]
        
        switch indexPath.row {
        case 0:
            cell.configure(descriptionTypes: .fio, patientInfo: filter.fio)
        case 1:
            cell.configure(descriptionTypes: .dateOfBirth, patientInfo: filter.dateOfBirth)
        case 2:
            cell.configure(descriptionTypes: .status, patientInfo:  filter.status)
        default:
            break
        }
        
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = CGColor(gray: 0.75, alpha: 1)
        return cell
    }
}


extension PatientsUIViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredPatients = []
        if searchText == ""{
            filteredPatients = patients
        }
        else{
            for item in patients {
                if item.fio.lowercased().contains(searchText.lowercased()){
                    filteredPatients.append(item)
                }
            }
            generalInfoTableView.reloadData()
        }
    }
}
