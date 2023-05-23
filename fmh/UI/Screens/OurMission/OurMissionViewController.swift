//
//  OurMissionViewController.swift
//  fmh
//
//  Created: 5/15/22
//

import UIKit

protocol OurMissionViewControllerProtocol: Presentable {
    
}

final class OurMissionViewController_: DIFCollectionViewController, OurMissionViewControllerProtocol {
    
    private func prepareCellModel(title: String) -> DIFItem {
        let description = "kjdgkjdgksjdg sjkjdhksjhd skjdhgksjdh kjshd\n shdjkhgskjdhgs djhskdjhgskjdhgs kjdhgksj"
        let item = OurMissionCellDIFModel(collectionView: collectionView, taglineLabel: title, descriptions: description)
        item.didTap = { item, index in
            print("\(item) \(index)")
        }
        return item
    }
    
    private func prepareCellModel2(title: String) -> DIFItem {
        let item = OurMissionCellDIFModel2(collectionView: collectionView, taglineLabel: title)
        item.didTap = { item, index in
            print("\(item) \(index)")
        }
        return item
    }
    
    private var section: DIFSection {
        
        var items = (0...10).map { prepareCellModel(title: "Item - \($0)") }
        let items2 = (0...10).map { prepareCellModel2(title: "Item2 - \($0)") }
        items.append(contentsOf: items2)
        
        return DIFSection(id: "Section-0", items: items)
    }
    
    override var content: [DIFSection] {
        [section]
    }
    
    // MARK: - Common init
    
    override func commonInit() {
        super.commonInit()
        collectionView.allowsMultipleSelection = true
    }
    
    // MARK: - Layout setup
    
    override func configureLayouts() -> UICollectionViewLayout? {
        let layout = UICollectionViewCompositionalLayout { section, layoutEnvironment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
            
            var group =  NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
//            if #available(iOS 16.0, *) {
//                group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 1)
//            } else {
//                group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
//            }
  
            let section = NSCollectionLayoutSection(group: group)
            
            return section
        }
        return layout
    }
    
    //
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt: \(indexPath)")
    }
}

final class OurMissionViewController: BaseViewController, OurMissionViewControllerProtocol {
    
    var presenter: OurMissionPresenterProtocol?
    
    // MARK: - UI
    
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
        view.backgroundView = UIImageView(image: UIImage(named: "bacground.main"))
        view.separatorStyle = .none
        view.rowHeight = UITableView.automaticDimension
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: - LifeCycle
    
    override func loadView() {
        super.loadView()
        setupUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Наша миссия"
 
        customTableView.register(OurMissionCell.self, forCellReuseIdentifier: OurMissionCell.identifier)
        customTableView.dataSource = self
        customTableView.delegate = self
    }
    
    // MARK: - Setup UI
    
    private func setupUI() {
        view.addSubview(taglineView)
        taglineView.addSubview(taglineLabel)
        view.addSubview(customTableView)
        
        NSLayoutConstraint.activate([
            taglineView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            taglineView.leftAnchor.constraint(equalTo: view.leftAnchor),
            taglineView.rightAnchor.constraint(equalTo: view.rightAnchor),
            taglineView.heightAnchor.constraint(equalToConstant: 44)
        ])
        
        NSLayoutConstraint.activate([
            taglineLabel.centerXAnchor.constraint(equalTo: taglineView.centerXAnchor),
            taglineLabel.centerYAnchor.constraint(equalTo: taglineView.centerYAnchor),
            taglineLabel.heightAnchor.constraint(equalToConstant: 28),
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

// MARK: - UIModuleOurMissionPresenterDelegate

extension OurMissionViewController: OurMissionPresenterDelegate {
    
}
