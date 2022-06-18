//
//  OurMissionCell.swift
//  fmh
//
//  Created: 5/15/22
//

import UIKit

class OurMissionCell: UITableViewCell, OurMissionCellProtocol {

    // MARK: - Parameters
    static let identifier = "OurMissionReusableIdentifier"
    
    private let cellView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.846, green: 0.846, blue: 0.846, alpha: 1).cgColor
        return view
    }()
    
    private let stackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.axis = .vertical
        view.distribution = .fill
        view.spacing = 9
        return view
    }()
    
    private let taglineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        return view
    }()
    private let taglineLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    private let arrowView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.image = UIImage(systemName: "chevron.down")
        view.tintColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.54)
        return view
    }()
    private let leafView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        view.image = UIImage(named: "LeafIcon")
        return view
    }()
    
    var isDescriptionHidden = true {
        willSet {
            animateCell(isHidden: newValue)
        }
    }
    
    // MARK: - Configure
    override func prepareForReuse() {
        super.prepareForReuse()
        taglineView.backgroundColor = nil
        taglineLabel.text = nil
        taglineLabel.backgroundColor = nil
        descriptionLabel.text = nil
    }
    
    func configure(cellData: OurMissionStruct?) {
        guard let cellData = cellData else { return }
        taglineView.backgroundColor = cellData.color
        taglineLabel.text = cellData.tagline
        taglineLabel.backgroundColor = cellData.color
        descriptionLabel.text = cellData.more
        isDescriptionHidden = cellData.isHidden
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
        cellView.addSubview(leafView)
        cellView.addSubview(arrowView)
        cellView.addSubview(stackView)
        
        stackView.addArrangedSubview(taglineView)
        taglineView.addSubview(taglineLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 29),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            leafView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 3),
            leafView.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 10),
            leafView.widthAnchor.constraint(equalToConstant: 31),
            leafView.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        NSLayoutConstraint.activate([
            arrowView.centerYAnchor.constraint(equalTo: leafView.centerYAnchor),
            arrowView.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -17)
        ])
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: cellView.centerXAnchor),
            stackView.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 9),
            stackView.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 33),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: cellView.bottomAnchor, constant: -9)
        ])
        
        NSLayoutConstraint.activate([
            taglineLabel.centerYAnchor.constraint(equalTo: taglineView.centerYAnchor),
            taglineLabel.centerXAnchor.constraint(equalTo: taglineView.centerXAnchor),
            taglineLabel.leftAnchor.constraint(equalTo: taglineView.leftAnchor, constant: 8),
            taglineLabel.topAnchor.constraint(equalTo: taglineView.topAnchor, constant: 6)
        ])
    }

    // MARK: - Actions
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func animateCell(isHidden: Bool) {
        let upDown = CGAffineTransform(rotationAngle: .pi * -0.999)
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.descriptionLabel.isHidden = isHidden ? true : false
            self?.arrowView.transform = isHidden ? .identity : upDown
        } completion: { [weak self] _ in
            self?.descriptionLabel.alpha = isHidden ? 0 : 1
        }
    }
}
