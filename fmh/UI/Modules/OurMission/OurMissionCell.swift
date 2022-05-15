//
//  OurMissionCell.swift
//  fmh
//
//  Created: 5/15/22
//

import UIKit

class OurMissionCell: UITableViewCell {

    // MARK: - Parameters
    static let identifier = "OurMissionReusableIdentifier"
    var touchDelegate: OurMissionViewController?
    
    let cellView = UIView()
    private let taglineView = UIView()
    private let taglineLabel = UILabel()
    private let descriptionLabel = UILabel()
    var isDescriptionLabelShown = false
    private var removableConstraints = [NSLayoutConstraint()]
    
    // MARK: - Configure
    override func prepareForReuse() {
        super.prepareForReuse()
        taglineView.backgroundColor = nil
        taglineLabel.text = nil
        taglineLabel.backgroundColor = nil
        descriptionLabel.text = nil
    }
    
    func configure(cellData: ourMissionStruct) {
        taglineView.backgroundColor = cellData.color
        taglineLabel.text = cellData.tagline
        taglineLabel.backgroundColor = cellData.color
        descriptionLabel.text = cellData.more
        setupUI()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Setup UI
    private func setupUI() {
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        self.addSubview(cellView)
        cellView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 29),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        cellView.clipsToBounds = true
        cellView.backgroundColor = .white
        cellView.layer.cornerRadius = 8
        cellView.layer.borderWidth = 1
        cellView.layer.borderColor = UIColor(red: 0.846, green: 0.846, blue: 0.846, alpha: 1).cgColor
        
        let leafView = UIImageView()
        cellView.addSubview(leafView)
        leafView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leafView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 3),
            leafView.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 10),
            leafView.widthAnchor.constraint(equalToConstant: 31),
            leafView.heightAnchor.constraint(equalToConstant: 28)
        ])
        leafView.clipsToBounds = true
        leafView.image = UIImage(named: "LeafIcon")
        
        let arrowView = UIImageView()
        cellView.addSubview(arrowView)
        arrowView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            arrowView.centerYAnchor.constraint(equalTo: leafView.centerYAnchor),
            arrowView.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -17)
        ])
        arrowView.clipsToBounds = true
        arrowView.image = UIImage(systemName: "chevron.down")
        arrowView.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.54)
        
        cellView.addSubview(taglineView)
        taglineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            taglineView.centerXAnchor.constraint(equalTo: cellView.centerXAnchor),
            taglineView.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 9),
            taglineView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 33),
            taglineView.bottomAnchor.constraint(lessThanOrEqualTo: cellView.bottomAnchor, constant: -9)
        ])
        taglineView.clipsToBounds = true
        taglineView.layer.cornerRadius = 5
        
        taglineView.addSubview(taglineLabel)
        taglineLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            taglineLabel.centerYAnchor.constraint(equalTo: taglineView.centerYAnchor),
            taglineLabel.centerXAnchor.constraint(equalTo: taglineView.centerXAnchor),
            taglineLabel.leftAnchor.constraint(equalTo: taglineView.leftAnchor, constant: 8),
            taglineLabel.topAnchor.constraint(equalTo: taglineView.topAnchor, constant: 6)
        ])
        taglineLabel.clipsToBounds = true
        taglineLabel.numberOfLines = 0
        taglineLabel.lineBreakMode = .byWordWrapping
        
        cellView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.clipsToBounds = true
        descriptionLabel.font = UIFont.systemFont(ofSize: 13)
        descriptionLabel.numberOfLines = 0
        descriptionLabel.lineBreakMode = .byWordWrapping
        
        removableConstraints = [
            descriptionLabel.centerXAnchor.constraint(equalTo: cellView.centerXAnchor),
            descriptionLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 9),
            descriptionLabel.topAnchor.constraint(equalTo: taglineView.bottomAnchor, constant: 9),
            descriptionLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -9)
        ]
        
        NSLayoutConstraint.deactivate(removableConstraints)
        descriptionLabel.isHidden = true
    }

    // MARK: - Actions
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
//
//    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        isDescriptionLabelShown.toggle()
//        if isDescriptionLabelShown {
//            NSLayoutConstraint.activate(removableConstraints)
//            descriptionLabel.isHidden = false
//        } else {
//            NSLayoutConstraint.deactivate(removableConstraints)
//            descriptionLabel.isHidden = true
//        }
//    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isDescriptionLabelShown.toggle()
        if isDescriptionLabelShown {
            NSLayoutConstraint.activate(removableConstraints)
            descriptionLabel.isHidden = false
        } else {
            NSLayoutConstraint.deactivate(removableConstraints)
            descriptionLabel.isHidden = true
        }
//        touchDelegate?.cardTouched()
    }
}
