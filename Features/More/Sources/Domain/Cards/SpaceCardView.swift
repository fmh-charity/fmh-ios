
import UIKit
import UIComponents

final class SpaceCardView: UIView {
    
    init(height: CGFloat = 16) {
        super.init(frame: .zero)
        heightAnchor.constraint(equalToConstant: height).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
