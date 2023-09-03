
import UIKit

// TODO: Возможно когда-то добавить поддержку UIButton.Configuration (IOS15+) !

public final class Button: UIButton, ViewCornersAvailable, ViewBordersAvailable, ViewShadowAvailable {
    
    // MARK: Public
    
    public var title: String? = nil {
        didSet { updateTitle(with: .normal) }
    }
    
    public var style: ButtonConfiguration.Style {
        didSet { updateStyle() }
    }
    
    public var controlState: ControlState {
        didSet { updateStyle(with: controlState) }
    }
    
    // MARK: - Life cycle
    
    public init(configuration: ButtonConfiguration = .default()) {
        self.controlState = configuration.state ?? .normal
        self.style = configuration.style
        self.title = configuration.title
        super.init(frame: .zero)
        updateStyle()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var intrinsicContentSize: CGSize {
        guard let size = style.size else {
            return super.intrinsicContentSize
        }
        return .init(width: size.width, height: size.height)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        setCapsuleStyle(style.isCapsule ?? false)
        if let shadows = style.shadows, !shadows.isEmpty {
            self.layer.shadowPath = cgPathWithRoundingCorners
        }
    }
    
    // MARK: - Private
    
    private func updateStyle() {
        
        // MARK: Set corners
        if let corners = style.corners {
            self.corners = corners
        }
        
        updateStyle(with: controlState)
        
        invalidateIntrinsicContentSize()
    }
    
    private func updateStyle(with state: ControlState) {
        
        // backgroundColor
        if let color = self.style.backgroundColors.first(where: { $0.state == state})?.color {
            self.backgroundColor = color
        }
        
        // borders
        if let borders = self.style.borders?.first(where: { $0.state == state})?.borders {
            self.borders = borders
        }
        
        // shadows
        if let shadow = self.style.shadows?.first(where: { $0.state == state})?.shadow {
            self.shadow = shadow
        }
        
        updateTitle(with: state)
    }
    
    private func updateTitle(with state: ControlState) {
        if let title = self.style.titleStyles.first(where: { $0.state == state}) {
            setTitleAttributedString(title: self.title, color: title.color, font: title.font, state: state)
        }
    }
    
    private func setTitleAttributedString(title: String?, color: UIColor?, font: UIFont?, state: ControlState) {
        var titleAttributes: [NSAttributedString.Key : Any] = [:]
        if let color { titleAttributes[.foregroundColor] = color }
        if let font { titleAttributes[.font] = font }
        let titleAttributedString = NSAttributedString(string: title ?? "", attributes: titleAttributes)
        setAttributedTitle(titleAttributedString, for: state.convertToUIControlState)
    }
    
    private func setCapsuleStyle(_ isActivate: Bool) {
        if isActivate {
            self.layer.maskedCorners = .allCornerMask
            self.layer.cornerRadius = self.bounds.height / 2.0
        } else {
            self.layer.maskedCorners = style.corners?.corners ?? .allCornerMask
            self.layer.cornerRadius = style.corners?.radius ?? 0.0
        }
        self.layer.masksToBounds = (self.layer.cornerRadius > 0) && (self.shadow == nil)
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
                if let scale = self.style.highlightedScale {
                    let scale = self.isHighlighted ? scale : 1.0
                    self.transform = .init(scaleX: scale, y: scale)
                }
                // highlightedOpacity
                if let opacity = self.style.highlightedOpacity {
                    self.layer.opacity = self.isHighlighted ? opacity : 1.0
                }
                self.controlState = self.isHighlighted ? .highlighted : .normal
            }
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            self.controlState = isEnabled ? .normal : .disabled
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
