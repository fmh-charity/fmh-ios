//
//  ChamberViewController.swift
//  fmh
//
//  Created: 01.07.2022
//

import UIKit

class ChamberViewController: UIViewController {
    
    // MARK: - Public properties
    let chamber: ChamberModel!
    
    let headerMenu = HeaderMenuView(labelText: "Палата", leftButtonImage: UIImage(systemName: "trash"), rightButtonImage: UIImage(systemName: "square.and.pencil"))
    
    // MARK: - Private properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ChamberTableViewCell.self, forCellReuseIdentifier: ChamberTableViewCell.identifier)
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    
    private lazy var doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.tintColor = .gray
        button.contentMode = .scaleAspectFit
        button.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    
    init(chamber: ChamberModel) {
        self.chamber = chamber
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupConstraints()
        setupBackground()
    }
    
    // MARK: - Private methods
    
    private func setupBackground() {
        view.backgroundColor = UIColor(patternImage: UIImage(named: "BackGround") ?? UIImage())
    }
    
    @objc private func doneButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - Setup constraints

extension ChamberViewController {
    
    private func addSubviews() {
        view.addSubview(headerMenu)
        view.addSubview(tableView)
        view.addSubview(doneButton)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            headerMenu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerMenu.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: headerMenu.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            doneButton.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
            doneButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1)
        ])
        
    }
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ChamberViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChamberTableViewCell.identifier, for: indexPath) as? ChamberTableViewCell else { return UITableViewCell() }
        
        cell.configure(numberOfChamber: chamber.numberOfChamber,
                       chamber: chamber.chamber,
                       numberOfPost: chamber.numberOfPost,
                       post: chamber.post,
                       numberOfBlock: chamber.numberOfBlock,
                       block: chamber.block,
                       numberOfFreePlaces: chamber.numberOfFreePlaces,
                       freePlaces: chamber.freePlaces,
                       comment: chamber.comment,
                       nameOfComment: chamber.nameOfComment)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
