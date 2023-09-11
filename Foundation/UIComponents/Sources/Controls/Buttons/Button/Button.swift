
import UIKit

// TODO: Возможно когда-то добавить поддержку UIButton.Configuration (IOS15+) !

public final class Button: UIButton, ViewCornersAvailable, ViewBordersAvailable, ViewShadowAvailable {
    
    // MARK: Public
    
    public var title: String? = nil {
        didSet { updateTitle(_style) }
    }
    
    // MARK: - Private
    
    private var _configuration: ButtonConfiguration {
        didSet { updateConfiguration(_configuration) }
    }
    
    private var _state: UIControl.State = .normal {
        didSet { updateStyle(_style) }
    }
    
    private var _style: ButtonConfiguration.Style? {
        _configuration.styles?[_state]
    }
    
    // MARK: - Life cycle
    
    public init(configuration: ButtonConfiguration = .default()) {
        self._configuration = configuration
        super.init(frame: .zero)
        updateConfiguration(_configuration)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var intrinsicContentSize: CGSize {
        guard let size = _configuration.size else {
            return super.intrinsicContentSize
        }
        return .init(width: .zero, height: size)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setCapsuleStyle(_configuration.isCapsule ?? false)
        if let _ = _style?.shadows {
            self.layer.shadowPath = cgPathWithRoundingCorners
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            _state = isEnabled ? .normal : .disabled
        }
    }
    
    // MARK: - Private
    
    public var size: CGFloat?
    
    private func updateConfiguration(_ configuration: ButtonConfiguration) {
        
        // Set corners
        if let corners = _configuration.corners {
            self.corners = corners
        }
        
        updateStyle(_style)
        
        invalidateIntrinsicContentSize()
    }
    
    private func updateStyle(_ style: ButtonConfiguration.Style?) {

        // backgroundColor
        if let backgroundColor = style?.backgroundColor {
            self.backgroundColor = backgroundColor
        }
        
        // Set borders
        if let borders = style?.borders {
            self.borders = borders
        }
        // Set shadows
        if let shadows = style?.shadows {
            self.shadow = shadows
        }
        
        updateTitle(style)
        
        invalidateIntrinsicContentSize()
    }
    
    private func updateTitle(_ style: ButtonConfiguration.Style?) {
        if let title = style?.titleStyle {
            setTitleAttributedString(title: self.title, color: title.color, font: title.font, state: _state)
        }
    }
    
    private func setTitleAttributedString(title: String?, color: UIColor?, font: UIFont?, state: UIControl.State) {
        var titleAttributes: [NSAttributedString.Key : Any] = [:]
        if let color { titleAttributes[.foregroundColor] = color }
        if let font { titleAttributes[.font] = font }
        let titleAttributedString = NSAttributedString(string: title ?? "", attributes: titleAttributes)
        setAttributedTitle(titleAttributedString, for: state)
    }
    
    private func setCapsuleStyle(_ isActivate: Bool) {
        if isActivate {
            self.layer.maskedCorners = .allCornerMask
            self.layer.cornerRadius = self.bounds.height / 2.0
        } else {
            self.layer.maskedCorners = self.corners?.corners ?? .allCornerMask
            self.layer.cornerRadius = self.corners?.radius ?? 0.0
        }
        self.layer.masksToBounds = (self.layer.cornerRadius > 0) && (self.shadow == nil)
    }
    
    // MARK: - Set state
    
    public func setState(_ state: UIControl.State) {
        if (state == .readOnly || state == .disabled) {
            isEnabled = false
            return
        }
        _state = state
    }
}

// MARK: - isHighlighted

extension Button {
    
    public override var isHighlighted: Bool {
        didSet {
            UIView.animate(
                withDuration: 0.05,
                delay: 0,
                options: [.allowUserInteraction, .beginFromCurrentState]
            ) {
                // highlightedScale
                if let scale = self._configuration.highlightedScale {
                    let scale = self.isHighlighted ? scale : 1.0
                    self.transform = .init(scaleX: scale, y: scale)
                }
                // highlightedOpacity
                if let opacity = self._configuration.highlightedOpacity {
                    self.layer.opacity = self.isHighlighted ? opacity : 1.0
                }
                self._state = self.isHighlighted ? .highlighted : .normal
            }
        }
    }
}

// MARK: - utils for shadow

private extension Button {

    var cgPathWithRoundingCorners: CGPath {
        get {
            UIBezierPath(
                roundedRect: self.bounds,
                byRoundingCorners: self.layer.maskedCorners.rectCorners,
                cornerRadii: CGSize(width: self.layer.cornerRadius, height: self.layer.cornerRadius)
            ).cgPath
        }
    }
}

private extension CACornerMask {
    
    var rectCorners: UIRectCorner {
        get {
            var rectCorners = UIRectCorner()
            if self.contains(.layerMinXMinYCorner) {
                rectCorners.insert(.topLeft)
            }
            
            if self.contains(.layerMaxXMinYCorner) {
                rectCorners.insert(.topRight)
            }
            
            if self.contains(.layerMinXMaxYCorner) {
                rectCorners.insert(.bottomLeft)
            }
            
            if self.contains(.layerMaxXMaxYCorner) {
                rectCorners.insert(.bottomRight)
            }
            return rectCorners
        }
    }
}

// MARK: - Unavailable

extension Button {

    @available(*, unavailable, message: "Use title value")
    public override func setTitle(_ title: String?, for state: UIControl.State) { }
}
