import UIKit

final class TaskCollectionViewCell: UICollectionViewCell {
    private let executorLabel = UILabel(text: "Исполнитель", font: UIFont.systemFont(ofSize: 13) , tintColor: UIColor(named: "TaskCollectionTextColor") ?? .black, textAlignment: .left)
    private let themeLabel = UILabel(text: "Тема", font: UIFont.systemFont(ofSize: 13) , tintColor: UIColor(named: "TaskCollectionTextColor") ?? .black, textAlignment: .left)
    static let reuseID = "TaskCollectionViewCell"
    let taskView = MainTaskTitle()
    let orangeView = OrangeView()
    let nameofThemeLabel = UILabel(text: "Тема1", font: UIFont.systemFont(ofSize: 16) , tintColor: .black, textAlignment: .right)
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   private func setupConstraints() {
        contentView.clipsToBounds = true
        contentView.addSubview(taskView)
        orangeView.addSubview(themeLabel)
        orangeView.addSubview(nameofThemeLabel)
        contentView.addSubview(orangeView)
        
        let constraints = [
            orangeView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            orangeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            orangeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            orangeView.bottomAnchor.constraint(equalTo: nameofThemeLabel.bottomAnchor),
            
            themeLabel.leadingAnchor.constraint(equalTo: orangeView.leadingAnchor, constant: 10),
            themeLabel.trailingAnchor.constraint(equalTo: nameofThemeLabel.leadingAnchor, constant: -30),
            themeLabel.topAnchor.constraint(equalTo: orangeView.topAnchor, constant: 10),
            themeLabel.bottomAnchor.constraint(equalTo: orangeView.bottomAnchor, constant: -10),
            
            nameofThemeLabel.leadingAnchor.constraint(equalTo: themeLabel.trailingAnchor, constant: 30),
            nameofThemeLabel.trailingAnchor.constraint(equalTo: orangeView.trailingAnchor, constant: -10),
            nameofThemeLabel.topAnchor.constraint(equalTo: orangeView.topAnchor),
            nameofThemeLabel.bottomAnchor.constraint(equalTo: orangeView.bottomAnchor),
            nameofThemeLabel.widthAnchor.constraint(equalTo: orangeView.widthAnchor, multiplier: 0.7),
            
            taskView.topAnchor.constraint(equalTo: orangeView.bottomAnchor),
            taskView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            taskView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
            taskView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            taskView.heightAnchor.constraint(equalToConstant: 98)
        ]
        NSLayoutConstraint.activate(constraints)
        backgroundColor = UIColor(named: "BackgroundTaskCell")
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingExpandedSize).height
        return layoutAttributes
    }
}


