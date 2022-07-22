//  NewsCell.swift
//  fmh
//
//  Created: 30.04.22


import UIKit

class NewsCell: UITableViewCell {
    
    private var resultView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private let newsIcon = UIImageView()
    
    private let newsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.avenirNext16()
        return label
    }()
    
    private var newsTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()
    
    private let newsDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = #colorLiteral(red: 0.9607843137, green: 0.9607843137, blue: 0.9607843137, alpha: 0.9325993337)
        label.font = UIFont.avenirNext13()
        label.textColor = #colorLiteral(red: 0.5294117647, green: 0.5294117647, blue: 0.5294117647, alpha: 1)
        return label
    }()
    
    private let cellLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let openNewsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var isExpanded: Bool = false {
        didSet {
            UIView.animate(withDuration: 0.3) {
                let upDown = CGAffineTransform(rotationAngle: .pi)
                self.openNewsImageView.transform = self.isExpanded ? upDown : .identity
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setViewModel(_ viewModel: NewsViewModel) {
        self.newsIcon.image = viewModel.imageName
        self.newsLabel.text = viewModel.title
        self.newsDate.text = viewModel.date
        self.openNewsImageView.image = .init(named: viewModel.image)
        self.isExpanded = viewModel.isExpanded 
        self.isExpanded ? (self.newsTextLabel.text = viewModel.text) : (self.newsTextLabel.text = "")
    }
    
    private func configureUI () {
        self.backgroundColor = UIColor(white: 0, alpha: 0)
        self.resultView.addSubview(self.newsIcon)
        self.contentView.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha: 1)
        self.contentView.addSubview(resultView)
        NSLayoutConstraint.activate([
            self.resultView.heightAnchor.constraint(greaterThanOrEqualToConstant: 70),
            self.resultView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0),
            self.resultView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 1),
            self.resultView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -1),
            self.resultView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -1)
        ])
        
        self.resultView.addSubview(self.newsDate)
        NSLayoutConstraint.activate([
            self.newsDate.trailingAnchor.constraint(equalTo: self.resultView.trailingAnchor, constant: -1),
            self.newsDate.bottomAnchor.constraint(equalTo: self.resultView.bottomAnchor, constant: -1),
            self.newsDate.widthAnchor.constraint(equalToConstant: 107),
            self.newsDate.heightAnchor.constraint(equalToConstant: 17)
        ])
        
        self.resultView.addSubview(self.openNewsImageView)
        NSLayoutConstraint.activate([
            self.openNewsImageView.trailingAnchor.constraint(equalTo: self.resultView.trailingAnchor, constant: -16),
            self.openNewsImageView.topAnchor.constraint(equalTo: self.resultView.topAnchor, constant: 25)
        ])
    
        self.resultView.addSubview(self.newsLabel)
        NSLayoutConstraint.activate([
            self.newsLabel.topAnchor.constraint(equalTo: self.newsIcon.topAnchor, constant: 2),
            self.newsLabel.leadingAnchor.constraint(equalTo: self.newsIcon.trailingAnchor, constant: 17),
            self.newsLabel.heightAnchor.constraint(equalToConstant: 19)
        ])
        
        self.resultView.addSubview(self.newsTextLabel)
        NSLayoutConstraint.activate([
            self.newsTextLabel.topAnchor.constraint(equalTo: self.newsLabel.bottomAnchor, constant: 5),
            self.newsTextLabel.leadingAnchor.constraint(equalTo: self.resultView.leadingAnchor, constant: 20),
            self.newsTextLabel.trailingAnchor.constraint(equalTo: self.resultView.trailingAnchor, constant: -10),
            self.newsTextLabel.bottomAnchor.constraint(equalTo: self.resultView.bottomAnchor, constant: -17)
        ])
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = CGRect(x: 20, y: 0, width: self.bounds.width - 40, height: self.bounds.height)
        self.newsIcon.frame = CGRect(x: 15, y: 15, width: 21, height: 20)
        self.openNewsImageView.frame = CGRect(x: 0, y: 0, width: 12, height: 7.41)
    }
    
}
