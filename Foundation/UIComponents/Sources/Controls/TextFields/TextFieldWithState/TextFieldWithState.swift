
import UIKit

// TODO:

open class TextFieldWithState: UITextField {
    
    // MARK: Public
    
    public var title: String? {
        didSet { titleLabel.text = title }
    }
    
    public var prompt: String? {
        didSet { promptLabel.text = prompt }
    }
    
    public override var placeholder: String? {
        didSet { updatePlaceholder(with: textFieldState) }
    }
    
    public var textFieldConfiguration: TextFieldWithStateConfiguration {
        didSet { updateConfiguration(textFieldConfiguration) }
    }
    
    public var textFieldState: TextFieldWithState.State = .normal {
        didSet { updateStateStyle(textFieldState) }
    }
    
    // MARK: UI
    
    private lazy var titleLabel: UILabel = {
        self.addSubview($0)
        $0.numberOfLines = 1
        return $0
    }(UILabel())
    
    private lazy var promptLabel: UILabel = {
        self.addSubview($0)
        $0.numberOfLines = 1
        return $0
    }(UILabel())
    
    private lazy var borderLayer: CALayer = {
        $0.removeFromSuperlayer()
        self.layer.addSublayer($0)
        $0.borderWidth = 1
        return $0
    }(CALayer())
    
    // MARK: - Life cycle
    
    public init(configuration: TextFieldWithStateConfiguration) {
        self.textFieldConfiguration = configuration
        super.init(frame: .zero)
        addTargetEditingChanged()
        updateConfiguration(textFieldConfiguration)
        updateStateStyle(textFieldState)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = titleRect(forBounds: bounds)
        promptLabel.frame = promptRect(forBounds: bounds)
        borderLayer.frame = borderLayerRect(forBounds: bounds)
    }
    
    open override func becomeFirstResponder() -> Bool {
        self.textFieldState = .focused
        return super.becomeFirstResponder()
    }
    
    open override func resignFirstResponder() -> Bool {
        self.textFieldState = .normal
        promptLabel.text = nil
        return super.resignFirstResponder()
    }
    
    // MARK: - Position views
    
    override open var intrinsicContentSize: CGSize {
        var height: CGFloat = titleLabel.height + promptLabel.height
        height += textFieldConfiguration.size ?? font?.lineHeight ?? 22.0
        if let insets = textFieldConfiguration.contentEdgeInsets {
            height += insets.top + insets.bottom
        }
        return CGSize(width: self.bounds.size.width, height: height)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        CGRect(
            x: 0,
            y: titleLabel.height,
            width: bounds.size.width,
            height: bounds.size.height - titleLabel.height - promptLabel.height
        ).inset(by: textFieldConfiguration.contentEdgeInsets ?? .zero)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    override open func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
        var rect = super.clearButtonRect(forBounds: bounds)
        rect.origin.x = rect.origin.x + (textFieldConfiguration.clearButtonOffsetX ?? 0)
        return rect
    }
    
    // MARK: Custom view position
    
    open func titleRect(forBounds bounds: CGRect) -> CGRect {
        CGRect(x: 0, y: 0, width: bounds.width, height: titleLabel.height)
    }
    
    open func promptRect(forBounds bounds: CGRect) -> CGRect {
        let y: CGFloat = bounds.height - promptLabel.height
        return CGRect(x: 0, y: y, width: bounds.width, height: promptLabel.height)
    }
    
    open func borderLayerRect(forBounds bounds: CGRect) -> CGRect {
        CGRect(
            x: 0,
            y: titleLabel.height,
            width: bounds.size.width,
            height: bounds.size.height - titleLabel.height - promptLabel.height
        ).inset(by: textFieldConfiguration.borderLayerEdgeInsets ?? .zero)
    }
    
    // MARK: - Set state styles
    
    open func updateConfiguration(_ configuration: TextFieldWithStateConfiguration) {
        
        // Set borderCornerRadius
        if let cornerRadius = configuration.borderCornerRadius {
            borderLayer.cornerRadius = cornerRadius
        }
        
        // Set clearButtonMode
        if let clearButtonMode = configuration.clearButtonMode {
            self.clearButtonMode = clearButtonMode
        }
        
        invalidateIntrinsicContentSize()
    }
    
    // MARK: - Set state styles
    
    open func updateStateStyle(_ state: TextFieldWithState.State) {
        
        // Set isEnabled
        self.isEnabled = !(state == .disabled || state == .readOnly)
        
        // Set backgroundColor
        if let backgroundColor = state.style?.backgroundColor {
            borderLayer.backgroundColor = backgroundColor.cgColor
        }

        // Set borderCornerRadius
        if let borderColor = state.style?.borderColor {
            borderLayer.borderColor = borderColor.cgColor
        }
        
        // Set titleStyle
        if let style = state.style?.titleStyle {
            titleLabel.textColor = style.0
            titleLabel.font = style.1
        }
        
        // Set textStyle
        updateText(with: state)
        
        // Set placeholderStyle
        updatePlaceholder(with: state)
        
        // Set promptStyle
        if let style = state.style?.promptStyle {
            promptLabel.textColor = style.0
            promptLabel.font = style.1
        }

        // Set clearButtonImage
        if
            let image = state.style?.clearButtonImage,
            let clearButton = value(forKeyPath: "_clearButton") as? UIButton
        {
            clearButton.setImage(image, for: .normal) // <- always normal!?
        }
        
        invalidateIntrinsicContentSize()
    }
}

// MARK: - Update help functions

private extension TextFieldWithState {
    
    func updateText(with state: TextFieldWithState.State) {
        if let style = state.style?.textStyle {
            defaultTextAttributes = makeAttributes(color: style.0, font: style.1)
        }
    }
    
    func updatePlaceholder(with state: TextFieldWithState.State) {
        if let style = state.style?.placeholderStyle {
            let attributes = makeAttributes(color: style.0, font: style.1)
            attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: attributes)
        }
    }
    
    func makeAttributes(color: UIColor?, font: UIFont?) -> [NSAttributedString.Key : Any] {
        var attributes: [NSAttributedString.Key : Any] = [:]
        if let color { attributes[.foregroundColor] = color }
        if let font { attributes[.font] = font }
        return attributes
    }
}

// MARK: - addTargetEditingChanged

private extension TextFieldWithState {
    
    func addTargetEditingChanged() {
        addTarget(self, action: #selector(editingChanged), for: .editingChanged)
    }
    
    @objc func editingChanged() {
        promptLabel.text = nil
    }
}

// MARK: - Helpers

private extension UILabel {
    
    var height: CGFloat {
        return self.font.lineHeight
    }
}
