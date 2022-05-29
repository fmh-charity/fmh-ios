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
            tableView.dataSource = self
            tableView.delegate = self
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.register(CommentTableCell.self, forCellReuseIdentifier: CommentTableCell.reuseId)
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        return 100
    }
    
}
