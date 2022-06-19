//
//  OurMissionViewController.swift
//  fmh
//
//  Created: 5/15/22
//

import UIKit

final class OurMissionViewController: UIViewController, OurMissioniewControllerProtocol {
    
    // MARK: - Parameters
    var presenter: OurMissionPresenterInput?
    var onCompletion: (() -> ())?
    
    private let taglineView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red: 0.892, green: 0.892, blue: 0.892, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let taglineLabel: UILabel = {
        let label = UILabel()
        label.clipsToBounds = true
        label.layer.cornerRadius = 6
        label.backgroundColor = UIColor(red: 0.821, green: 1, blue: 0.998, alpha: 1)
        label.font.withSize(19   )
        label.textColor = UIColor(red: 0, green: 0.506, blue: 0.498, alpha: 1)
        label.textAlignment = .center
        label.text = "Главное - жить любя"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let customTableView: UITableView = {
        let view = UITableView()
        view.clipsToBounds = true
        view.backgroundView = UIImageView(image: UIImage(named: "BackGround"))
        view.separatorStyle = .none
        view.rowHeight = UITableView.automaticDimension
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func loadView() {
        super.loadView()
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customTableView.register(OurMissionCell.self, forCellReuseIdentifier: OurMissionCell.identifier)
        customTableView.dataSource = self
        customTableView.delegate = self
    }
    
    // MARK: - Constraints
    private func setupUI() {
        view.addSubview(taglineView)
        taglineView.addSubview(taglineLabel)
        view.addSubview(customTableView)
        
        NSLayoutConstraint.activate([
            taglineView.topAnchor.constraint(equalTo: view.topAnchor),
            taglineView.leftAnchor.constraint(equalTo: view.leftAnchor),
            taglineView.rightAnchor.constraint(equalTo: view.rightAnchor),
            taglineView.heightAnchor.constraint(equalToConstant: 68)
        ])
        
        NSLayoutConstraint.activate([
            taglineLabel.centerXAnchor.constraint(equalTo: taglineView.centerXAnchor),
            taglineLabel.centerYAnchor.constraint(equalTo: taglineView.centerYAnchor),
            taglineLabel.heightAnchor.constraint(equalToConstant: 32),
            taglineLabel.widthAnchor.constraint(equalToConstant: 211)
        ])
        
        NSLayoutConstraint.activate([
            customTableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            customTableView.topAnchor.constraint(equalTo: taglineView.bottomAnchor),
            customTableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            customTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - DataSource
extension OurMissionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter?.dataArray.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OurMissionCell.identifier, for: indexPath) as! OurMissionCell
        cell.configure(cellData: (presenter?.dataArray[indexPath.row]))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = customTableView.cellForRow(at: indexPath) as! OurMissionCell

        customTableView.beginUpdates()
       
        cell.isDescriptionHidden.toggle()
        presenter?.dataArray[indexPath.row].isHidden.toggle()
        
        customTableView.endUpdates()
    }
}

extension OurMissionViewController: OurMissionPresenterOutput {
}
