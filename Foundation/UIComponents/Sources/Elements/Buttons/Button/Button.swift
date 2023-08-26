
import UIKit

// TODO: Возможно когда-то добавить поддержку UIButton.Configuration (IOS15+) !

public class Button: UIButton, ViewCornersAvailable, ViewBordersAvailable, ViewShadowAvailable {
    
    // MARK: Static
    
    public static let statesAvailable: [UIControl.State] = {
        [.normal, .disabled, .highlighted]
    }()
    
    // MARK: Public
    
    public var style: ButtonStyle {
        didSet { updateStyle() }
    }
    
    public var title: String? = nil {
        didSet {
            updateTitle()
        }
    }
    
    // MARK: - Life cycle
    
    public init(configuration: ButtonConfiguration = .default()) {
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
        
        // MARK: Set background color if used normal state
        if let color = style.backgroundColors.first(where: { $0.state == .normal})?.color {
            self.backgroundColor = color
        }

        // MARK: Set corners
        if let corners = style.corners {
            self.corners = corners
        }
        
        // MARK: Set borders
        if let borders = style.borders?.first(where: { $0.state == .normal})?.borders {
            self.borders = borders
        }

        // MARK: Set shadow
        if let shadow = style.shadows?.first(where: { $0.state == .normal})?.shadow {
            self.shadow = shadow
        }
 
        updateTitle()
        
        invalidateIntrinsicContentSize()
    }
    
    private func updateTitle() {
        style.titleStyles.forEach {
            if Button.statesAvailable.contains($0.state) {
                setTitleAttributedString(title: title, color: $0.color, font: $0.font, state: $0.state)
            }
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
                // backgroundColor
                let state: UIControl.State = self.isHighlighted ? .highlighted : .normal
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
            }
        }
    }
    
    public override var isEnabled: Bool {
        didSet {
            // backgroundColors
            let state: UIControl.State = isEnabled ? .normal : .disabled
            if let color = style.backgroundColors.first(where: { $0.state == state})?.color {
                self.backgroundColor = color
            }
            // borders
            if let borders = style.borders?.first(where: { $0.state == state})?.borders {
                self.borders = borders
            }
            // shadows
            if let shadow = self.style.shadows?.first(where: { $0.state == state})?.shadow {
                self.shadow = shadow
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
    
    static let allCornerMask: CACornerMask = [
        .layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner
    ]
}

// MARK: - Unavailable

extension Button {
    
    @available(*, unavailable, message: "Use title value")
    public override func setTitle(_ title: String?, for state: UIControl.State) { }
}
