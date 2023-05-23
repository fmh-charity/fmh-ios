
import UIKit

@available(iOS 13.0, tvOS 13.0, *)
open class DIFCollectionReusableView: UICollectionReusableView, DIFCollectionReusableViewProtocol {
    
    public var indexPath: IndexPath?
    
    open var model: DIFItem? {
        /* Override in child */
        didSet { }
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        setupGestureRecognizers()
        commonInit()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func commonInit() { /* Override in child */ }
    
    private func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        tapGesture.delaysTouchesBegan = true
        addGestureRecognizer(tapGesture)
    }
    
    @objc
    private func handleTapGesture(_ gesture: UIGestureRecognizer) {
        
        guard gesture.state == .ended else { return }
        
        if let model = model, let indexPath = indexPath {
            (self.model as? DIFActionableItem)?.didTap?(model, indexPath)
        }
    }
    
}
