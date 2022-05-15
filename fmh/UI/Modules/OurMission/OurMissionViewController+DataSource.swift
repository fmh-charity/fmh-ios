//
//  OurMissionViewController+DataSource.swift
//  fmh
//
//  Created: 5/15/22
//

import UIKit

extension OurMissionViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        7
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: OurMissionCell.identifier, for: indexPath) as! OurMissionCell
        cell.configure()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! OurMissionCell
        cell.cellTouched()
        tableView.reloadData()
    }
    
}
