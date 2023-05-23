//
//  DIFCollectionViewCell.swift
//  fmh
//
//  Created: 23.05.2023
//

import UIKit

@available(iOS 13.0, tvOS 13.0, *)
class DIFCollectionViewCell: UICollectionViewCell, DIFCollectionViewCellProtocol {
    
    var indexPath: IndexPath?
    
    var model: DIFItem? {
        /* Override in child */
        didSet { }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        setupGestureRecognizers()
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() { /* Override in child */ }
    
    private func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        tapGesture.delaysTouchesBegan = false
        addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func handleTapGesture(_ gesture: UIGestureRecognizer) {
       
        guard gesture.state == .ended else { return }
        
        if let model = model, let indexPath = indexPath {
            (self.model as? DIFActionableItem)?.didTap?(model, indexPath)
        }
    }
    
    // переопределить делегат отбрасывания нажатия
    
}
