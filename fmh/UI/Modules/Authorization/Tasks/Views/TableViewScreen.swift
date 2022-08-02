//
//  TableViewScreen.swift
//  fmh
//
//  Created: 27.05.22
//

import UIKit

final class TableViewScreen: UIView {
    var tableView: UITableView?
    var newCommentComplition: (() -> ())?
    var editCommentComplition: ((Int) -> ())?
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
            return commentCellModels.count
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
        cell.commentNumLabel.text = commentCellModels[indexPath.row].comment
        cell.fioLabel.text = commentCellModels[indexPath.row].creatorName
        cell.dateLabel.text = commentCellModels[indexPath.row].date
        cell.timeLabel.text = commentCellModels[indexPath.row].time
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return UITableView.automaticDimension
        }
        return 38
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            self.newCommentComplition?()
        }
        if indexPath.section == 0 {
            print(indexPath.row)
            self.editCommentComplition?(indexPath.row)
        }
    }

}

