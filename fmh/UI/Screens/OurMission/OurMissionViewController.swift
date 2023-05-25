//
//  OurMissionViewController.swift
//  fmh
//
//  Created: 5/15/22
//

import UIKit

protocol OurMissionViewControllerProtocol: Presentable {
    
}

final class OurMissionViewController: DIFCollectionViewController, OurMissionViewControllerProtocol {

    var presenter: OurMissionPresenterProtocol?

    var section: DIFSection {
        let items = presenter?.dataArray.map({prepareCellModel(from: $0)})
        return DIFSection(id: "section - 0", items: items ?? [])
    }

    override var content: [DIFSection] {
        []
    }

    // MARK: -  LifeCycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        assert(presenter != nil, "presenter is nil")
        diffDataSource?.apply(sections: [section])
    }

    // MARK: - Common init
    
    override func commonInit() {
        super.commonInit()
        title = "Наша миссия"
        collectionView.allowsMultipleSelection = true
        view.backgroundColor = UIColor(patternImage: UIImage(named: "bacground.main") ?? UIImage())
    }

    private func prepareCellModel(from ourMissionModel: OurMissionStruct) -> DIFItem {
        let tagline = ourMissionModel.tagline
        let description = ourMissionModel.more
        let taglineColor = ourMissionModel.color
        let item = OurMissionCellDIFModel(collectionView: collectionView, taglineLabel: tagline, descriptions: description, taglineColor: taglineColor)
        item.didTap = { item, index in
            print("\(item) \(index)")
        }
        return item
    }

    // MARK: - Layout setup

    override func configureLayouts() -> UICollectionViewLayout? {
        let layout = UICollectionViewCompositionalLayout { section, layoutEnvironment in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(1))

            let group =  NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)

            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 16, leading: 16, bottom: 0, trailing: 16)
            section.interGroupSpacing = 30
            
            return section
        }
        return layout
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt: \(indexPath)")
    }
}

extension OurMissionViewController: OurMissionPresenterDelegate {

}
