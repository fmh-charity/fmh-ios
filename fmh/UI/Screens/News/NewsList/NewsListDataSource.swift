//
//  NewsListDataSource.swift
//  fmh
//
//  Created: 14.06.2022
//

import UIKit

class NewsListDataSource: NSObject {
    
    typealias DataType = News
    typealias CellType = NewsListCollectionViewCell
    
    weak var collectionView: UICollectionView?
 
    private let sizingCell = CellType()
    private var toogleSortData: Bool = false
    
    var data: [DataType] = [] {
        didSet {
            collectionView?.reloadData()
        }
    }
    
    init(collectionView: UICollectionView) {
        super.init()
        self.collectionView = collectionView
        collectionView.register(CellType.self, forCellWithReuseIdentifier: CellType.identifier)
    }

    func toggleSortData() {
        if toogleSortData {
            self.data.sort { $0.publishDate < $1.publishDate }
            self.toogleSortData = false
        } else {
            self.toogleSortData = true
            self.data.sort { $0.publishDate > $1.publishDate }
        }
    }
    
    func filterData(categary: Int, dateStart: Date? = nil, dateEnd: Date? = nil) {
        var data = self.data.filter{ $0.creatorId == categary }

        if let dateStart = dateStart, let dateEnd = dateEnd {
            data = data.filter{ $0.publishDate <= dateStart && $0.publishDate <= dateEnd }
            
        }
        
        self.data = data
    }
    
}

// MARK: - UICollectionViewDataSource
extension NewsListDataSource: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellType.identifier, for: indexPath) as? CellType {
            let item = data[indexPath.row]
            cell.configure(model: item, id: String(indexPath.row))
            return cell
        }
        return UICollectionViewCell()
    }
    
}

// MARK: - UICollectionViewDelegate
extension NewsListDataSource: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.performBatchUpdates(nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.performBatchUpdates(nil)
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension NewsListDataSource: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let isSelected = collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false
        sizingCell.isSelected = isSelected
        let item = data[indexPath.row]
        sizingCell.configure(model: item, id: String(indexPath.row))
        let height = sizingCell.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        let width = collectionView.referenceWidth()
        
        return .init(width: width, height: height)
    }

}

//MARK: - ReferenceWidth
fileprivate extension UICollectionView {
    func referenceWidth() -> CGFloat {
        guard let sectionInset = (self.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset else {
            return .zero
        }
        let referenceWidth = self.safeAreaLayoutGuide.layoutFrame.width
        - sectionInset.left
        - sectionInset.right
//        - self.contentInset.left
//        - self.contentInset.right
        
        return referenceWidth
    }
}
