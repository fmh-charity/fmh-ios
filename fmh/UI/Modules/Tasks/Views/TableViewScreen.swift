//
//  TableViewScreen.swift
//  fmh
//
//  Created: 27.05.22
//

import UIKit

class TableViewScreen: UIView {
    private var tableView: UITableView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        tableView = UITableView()
        tableViewLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func tableViewLayout() {
        if let tableView = tableView {
            tableView.separatorStyle = .none
            tableView.dataSource = self
            tableView.delegate = self
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.register(CommentTableCell.self,
                               forCellReuseIdentifier: CommentTableCell.reuseId)
            tableView.register(AddCommentTableViewCell.self,
                               forCellReuseIdentifier: AddCommentTableViewCell.reuseId)
            addSubview(tableView)
            tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        }
        else {print ("errrorrrrrrr")}
    }
}

extension TableViewScreen: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddCommentTableViewCell.reuseId, for: indexPath) as? AddCommentTableViewCell else {
                return UITableViewCell()
            }
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentTableCell.reuseId, for: indexPath) as? CommentTableCell else {
            return UITableViewCell()
        }
        cell.commentNumLabel.text = "Комментарий \(indexPath.row + 1)"
        cell.fioLabel.text = "М.М.Максимка"
        cell.dateLabel.text = "12.12.2021"
        cell.timeLabel.text = "15:55"
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return tableView.bounds.height * 0.35
        }
        return 38
    }

}

