//
//  CollectionViewAdapter.swift
//  fmh
//
//  Created: 30.05.2022
//

import Foundation
import UIKit

protocol CollectionViewAdapterDelegate: AnyObject {
    func configure(model: Any, view: UICollectionReusableView, indexPath: IndexPath)
    func didSelect(model: Any, indexPath: IndexPath)
    func didDeselect()
    func sizeCell(item: CollectionViewSection.Item, collectionView: UICollectionView, indexPath: IndexPath) -> CGSize
    func sizeHeader(header: CollectionViewSection.Header, collectionView: UICollectionView, section: Int) -> CGSize
    func sizeFooter(footer: CollectionViewSection.Footer, collectionView: UICollectionView, section: Int) -> CGSize
}


class CollectionViewAdapter: NSObject {
    
    typealias Section = CollectionViewSection
    
    weak var collectionView: UICollectionView?
    weak var delegate: CollectionViewAdapterDelegate?
 
    var sections: [Section] = [] {
        didSet {
            self.registerViewsInCollectionView(sections)
            self.collectionView?.reloadData()
        }
    }
    
    required init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        super.init()
    }
    
    private func registerViewsInCollectionView (_ sections: [Section]) {
        for section in sections {
            if let header = section.header {
                collectionView?.register (
                    header.viewType.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: header.viewType.identifier)
            }
            if let footer = section.footer {
                collectionView?.register (
                    footer.viewType.self,
                    forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                    withReuseIdentifier: footer.viewType.identifier)
            }
            for item in section.items {
                collectionView?.register(item.viewType.self, forCellWithReuseIdentifier: item.viewType.identifier)
            }
        }
    }
    
}

// MARK: - UICollectionViewDataSource
extension CollectionViewAdapter: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let header = sections[indexPath.section].header, kind == UICollectionView.elementKindSectionHeader {
            let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: header.viewType.identifier,
                for: indexPath
            )
            
            delegate?.configure(model: header.model, view: view, indexPath: indexPath)
            return view
            
        } else if let footer = sections[indexPath.section].footer, kind == UICollectionView.elementKindSectionFooter {
            let view = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionFooter,
                withReuseIdentifier: footer.viewType.identifier,
                for: indexPath
            )
            
            delegate?.configure(model: footer.model, view: view, indexPath: indexPath)
            return view
            
        } else {
            return UICollectionReusableView()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = sections[indexPath.section].items[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: item.viewType.identifier, for: indexPath)

        delegate?.configure(model: item.model, view: cell, indexPath: indexPath)
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension CollectionViewAdapter: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = sections[indexPath.section].items[indexPath.row]
        delegate?.didSelect(model: item.model, indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        delegate?.didDeselect()
    }
    
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CollectionViewAdapter: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let item = sections[indexPath.section].items[indexPath.row]
        if let size = delegate?.sizeCell(item: item, collectionView: collectionView, indexPath: indexPath) {
            return size
        }
        
        if let size = (collectionViewLayout as? UICollectionViewFlowLayout)?.itemSize {
            return size
        }
        
        return collectionView.frame.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        guard let header = sections[section].header else { return .zero }
        
        guard let size = delegate?.sizeHeader(header: header, collectionView: collectionView, section: section) else {
            return .zero
        }
        
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        
        guard let footer = sections[section].footer else { return .zero }
        
        guard let size = delegate?.sizeFooter(footer: footer, collectionView: collectionView, section: section) else {
            return .zero
        }
        
        return size
    }
    
}
