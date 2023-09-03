
import UIKit

// TODO:

public final class TextField: UITextField, ViewCornersAvailable, ViewBordersAvailable {
    
    // MARK: Public
    
    public override var placeholder: String? {
        didSet { updatePlaceholder(with: .normal) }
    }
    
    public override var leftView: UIView? {
        didSet {
            let mode = style.leftViewMode ?? .never
            leftViewMode = (leftView != nil) ? mode : .never
        }
    }
    
    public override var rightView: UIView? {
        didSet {
            let mode = style.rightViewMode ?? .never
            rightViewMode = (rightView != nil) ? mode : .never
        }
    }
    
    public var style: TextFieldConfiguration.Style {
        didSet { updateStyle() }
    }
    
    public var controlState: ControlState {
        didSet { updateStyle(with: controlState) }
    }
    
    // MARK: - Life cycle
    
    public init(configuration: TextFieldConfiguration = .default()) {
        self.controlState = configuration.state ?? .normal
        self.style = configuration.style
        super.init(frame: .zero)
        self.text = configuration.text
        self.placeholder = configuration.placeholder
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
    
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: style.contentEdgeInsets ?? .zero)
    }
    
    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        return rect.inset(by: style.contentEdgeInsets ?? .zero)
    }
    
    public override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.leftViewRect(forBounds: bounds)
        return rect.inset(by: style.leftViewEdgeInsets ?? .zero)
    }
    
    public override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.rightViewRect(forBounds: bounds)
        return rect.inset(by: style.rightViewEdgeInsets ?? .zero)
    }
    
    // MARK: - Private
    
    private func updateStyle() {
        
        if let corners = style.corners {
            self.corners = corners
        }
        
        if let clearButtonMode = style.clearButtonMode {
            self.clearButtonMode = clearButtonMode
        }
        
        updateStyle(with: controlState)
        
        invalidateIntrinsicContentSize()
    }
    
    private func updateStyle(with state: ControlState) {
        // Set isEnabled
        self.isEnabled = !(state == .disabled || state == .readOnly)
        
        // title
        updateText(with: state)
        
        // placeholderStyles
        updatePlaceholder(with: state)
        
        // backgroundColor
        if let color = self.style.backgroundColors?.first(where: { $0.state == state})?.color {
            self.backgroundColor = color
        }
        
        // borders
        if let borders = self.style.borders?.first(where: { $0.state == state})?.borders {
            self.borders = borders
        }
        
        // leftView
        if let view = self.style.leftViews?.first(where: { $0.state == state})?.view {
            self.leftView = view
        }
        
        // rightView
        if let view = self.style.rightViews?.first(where: { $0.state == state})?.view {
            self.rightView = view
        }
    }
    
    private func updateText(with state: ControlState) {
        if let style = style.texts.first(where: { $0.state == state}) {
            defaultTextAttributes = makeAttributes(color: style.color, font: style.font)
        }
    }
    
    private func updatePlaceholder(with state: ControlState) {
        if let style = style.placeholders.first(where: { $0.state == state}) {
            let attributes = makeAttributes(color: style.color, font: style.font)
            attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: attributes)
        }
    }
    
    private func makeAttributes(color: UIColor?, font: UIFont?) -> [NSAttributedString.Key : Any] {
        var attributes: [NSAttributedString.Key : Any] = [:]
        if let color { attributes[.foregroundColor] = color }
        if let font { attributes[.font] = font }
        return attributes
    }
}
