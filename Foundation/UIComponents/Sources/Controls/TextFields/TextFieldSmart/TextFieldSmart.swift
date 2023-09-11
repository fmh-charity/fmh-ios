
import UIKit

// MARK: - TextFieldSmart

open class TextFieldSmart: UITextField {
    
    // MARK: Public
    
    public var title: String? {
        didSet { titleLabel.text = title }
    }
    
    public var prompt: String? {
        didSet { promptLabel.text = prompt }
    }
    
    // MARK: private
    
    private var _configuration: TextFieldSmartConfiguration {
        didSet { updateConfiguration(_configuration) }
    }
    
    private var _state: UIControl.State = .normal {
        didSet { updateStyle(_style) }
    }
    
    private var _style: TextFieldSmartConfiguration.Style? {
        _configuration.styles?[_state]
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
    
    public init(configuration: TextFieldSmartConfiguration) {
        self._configuration = configuration
        super.init(frame: .zero)
        addTargetEditingChanged()
        updateConfiguration(_configuration)
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
    
    @discardableResult
    open override func becomeFirstResponder() -> Bool {
        self._state = .focused
        return super.becomeFirstResponder()
    }
    
    @discardableResult
    open override func resignFirstResponder() -> Bool {
        self._state = .normal
        promptLabel.text = nil
        return super.resignFirstResponder()
    }
    
    public override var isEnabled: Bool {
        didSet {
            _state = isEnabled ? .normal : .disabled
        }
    }
    
    open override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return contentRect(forBounds: bounds).contains(point)
    }
    
    // MARK: - Private help vars
    
    private var titleLabelHeight: CGFloat {
        titleLabel.height
    }
    
    private var promptLabelHeight: CGFloat {
        promptLabel.height
    }
    
    private var textLabelHeight: CGFloat {
        font?.lineHeight ?? 22.0
    }
    
    // MARK: - Position views
    
    override open var intrinsicContentSize: CGSize {
        var height: CGFloat = titleLabelHeight + promptLabelHeight
        if let size = _configuration.size {
            height += size
        } else {
            height += textLabelHeight
            let textEdgeInsets = _configuration.textEdgeInsets ?? .zero
            height += textEdgeInsets.top + textEdgeInsets.bottom
        }
        let contentEdgeInsets = _configuration.contentEdgeInsets ?? .zero
        height += contentEdgeInsets.top + contentEdgeInsets.bottom
        return CGSize(width: self.bounds.size.width, height: height)
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = contentRect(forBounds: bounds)
        return rect.inset(by: _configuration.textEdgeInsets ?? .zero)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    // MARK: Custom view position
    
    open func contentRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(
            x: 0,
            y: titleLabelHeight,
            width: bounds.size.width,
            height: bounds.size.height - titleLabelHeight - promptLabelHeight
        ).inset(by: _configuration.contentEdgeInsets ?? .zero)
    }
    
    open func titleRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: bounds.width, height: titleLabelHeight)
    }
    
    open func promptRect(forBounds bounds: CGRect) -> CGRect {
        let y: CGFloat = bounds.height - promptLabelHeight
        return CGRect(x: 0, y: y, width: bounds.width, height: promptLabelHeight)
    }
    
    open func borderLayerRect(forBounds bounds: CGRect) -> CGRect {
        return contentRect(forBounds: bounds)
    }
    
    // MARK: - Set state styles
    
    public func updateConfiguration(_ configuration: TextFieldSmartConfiguration) {
        
        // Set corners
        if let corners = configuration.corners {
            borderLayer.cornerRadius = corners.radius
            borderLayer.maskedCorners = corners.corners
        }
        
        // Set clearButtonMode
        if let clearButtonMode = configuration.clearButtonMode {
            self.clearButtonMode = clearButtonMode
        }
        
        updateStyle(_style)
        
        invalidateIntrinsicContentSize()
    }
    
    // MARK: - Set state styles
    
    public func updateStyle(_ style: TextFieldSmartConfiguration.Style?) {
        
        guard let style else { return }
        
        // Set backgroundColor
        if let backgroundColor = style.backgroundColor {
            borderLayer.backgroundColor = backgroundColor.cgColor
        }
        
        // Set borders
        if let borders = style.borders {
            borderLayer.borderColor = borders.cgColor
            borderLayer.borderWidth = borders.width
        }
        
        // Set clearButtonImage
        if
            let image = style.clearButtonImage,
            let clearButton = value(forKeyPath: "_clearButton") as? UIButton
        {
            clearButton.setImage(image, for: _state) // <- always normal!?
        }
        
        // Set titleStyle
        if let titleStyle = style.titleStyle {
            titleLabel.textColor = titleStyle.color
            titleLabel.font = titleStyle.font
        }
        
        // Set textStyle
        if let textStyle = style.textStyle {
            defaultTextAttributes = makeAttributes(color: textStyle.color, font: textStyle.font)
        }
        
        // Set placeholderStyle
        if let placeholderStyle = style.placeholderStyle {
            let attributes = makeAttributes(color: placeholderStyle.color, font: placeholderStyle.font)
            attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: attributes)
        }
        
        // Set promptStyle
        if let promptStyle = style.promptStyle {
            promptLabel.textColor = promptStyle.color
            promptLabel.font = promptStyle.font
        }
        
        invalidateIntrinsicContentSize()
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

// MARK: - Update help functions

private extension TextFieldSmart {
    
    func makeAttributes(color: UIColor?, font: UIFont?) -> [NSAttributedString.Key : Any] {
        var attributes: [NSAttributedString.Key : Any] = [:]
        if let color { attributes[.foregroundColor] = color }
        if let font { attributes[.font] = font }
        return attributes
    }
}

// MARK: - addTargetEditingChanged

private extension TextFieldSmart {
    
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
