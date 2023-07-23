//
//  DIFCollectionViewCellModel.swift
//  fmh
//
//  Created: 23.05.2023
//

import UIKit

@available(iOS 13.0, tvOS 13.0, *)
class DIFCollectionViewCellModel<T: UICollectionViewCell>: DIFItem, DIFCollectionViewCellModelProtocol where T: DIFConfigurable {
    
    private var indexPath: IndexPath?
    var didTap: ((_ item: T.ConfigurationModel, _ indexPath: IndexPath) -> Void)?
    var model: T.ConfigurationModel?
    
    private var reuseIdentifier: String { String(describing: T.self) }

    private lazy var tapGesture: UITapGestureRecognizer = {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        tapGesture.name = "DIFDidTapGestureRecognizer"
        tapGesture.cancelsTouchesInView = false
        return tapGesture
    }()
    
    init(_ collectionView: UICollectionView, id: String) {
        super.init(id: id)
        collectionView.register(T.self, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func getCell(_ collectionView: UICollectionView, for indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        self.indexPath = indexPath
        
        if let model {
            (cell as? T)?.configure(with: model)
        }
        
        if didTap != nil {
            cell.addGestureRecognizer(tapGesture)
        }
        
        return cell
    }
    
    @objc private func handleTapGesture(_ gesture: UIGestureRecognizer) {
        
        guard gesture.state == .ended else { return }
        
        if let model = model, let indexPath = indexPath {
            didTap?(model, indexPath)
        }
    }
}
