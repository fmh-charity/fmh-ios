
import UIKit

private enum Default {
    public static let titleColor: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    public static let titleFont: UIFont = .systemFont(ofSize: 16.0)
    public static let highlightedScale: CGFloat = 0.98
}

public class Button: UIButton, ViewCornersAvailable {
    
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
    
    // MARK: - Private
    
    private func updateStyle() {
        
        // MARK:
        self.backgroundColor = style.backgroundColor
        
        // MARK: Set corners
        if let corners = style.corners {
            self.corners = corners
        }
        
        // MARK: Set backgroundImage
        style.stateStyles?.forEach {
            if let backgroundImage = $0.backgroundImage {
                setBackgroundImage(backgroundImage, for: $0.state)
            }
        }
        
        updateTitle()
        
        invalidateIntrinsicContentSize()
    }
    
    private func updateTitle() {
        style.stateStyles?.forEach {
            if let titleStyle = $0.titleStyle {
                setTitleAttributedString(title: title, color: titleStyle.color, font: titleStyle.font, state: $0.state)
            }
        }
    }
    
    private func setTitleAttributedString(title: String?, color: UIColor? = nil, font: UIFont? = nil, state: UIControl.State) {
        let titleAttributedString = NSAttributedString(string: title ?? "", attributes: [
            .foregroundColor: color ?? Default.titleColor,
            .font: font ?? Default.titleFont
        ])
        setAttributedTitle(titleAttributedString, for: state)
    }
}

// MARK: - isHighlighted

extension Button {
    
    public override var isHighlighted: Bool {
        didSet {
            let scale = isHighlighted ? (style.highlightedScale ?? Default.highlightedScale) : 1.0
            UIView.animate(
                withDuration: 0.05,
                delay: 0,
                options: [.allowUserInteraction, .beginFromCurrentState]
            ) {
                self.transform = .init(scaleX: scale, y: scale)
            }
        }
    }
}

// MARK: - Unavailable

extension Button {
    
    @available(*, unavailable, message: "Use title value")
    public override func setTitle(_ title: String?, for state: UIControl.State) { }
    
    //    @available(*, unavailable, message: "Use Style")
    //    public override func setTitleShadowColor(_ color: UIColor?, for state: UIControl.State) { }
    //
    //    @available(*, unavailable, message: "Use Style")
    //    public override func setBackgroundImage(_ image: UIImage?, for state: UIControl.State) { }
}
