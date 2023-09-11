
import UIKit

public final class TextFieldBasic: UITextField, ViewCornersAvailable, ViewBordersAvailable {
    
    // MARK: - Private
    
    private var _configuration: TextFieldBasicConfiguration {
        didSet { updateConfiguration(_configuration) }
    }
    
    private var _state: UIControl.State = .normal {
        didSet { updateStyle(_style) }
    }
    
    private var _style: TextFieldBasicConfiguration.Style? {
        _configuration.styles?[_state]
    }
    
    // MARK: - UI
    
    public override var leftView: UIView? {
        didSet {
            let mode = _configuration.leftViewMode ?? .never
            leftViewMode = (leftView != nil) ? mode : .never
        }
    }
    
    public override var rightView: UIView? {
        didSet {
            let mode = _configuration.rightViewMode ?? .never
            rightViewMode = (rightView != nil) ? mode : .never
        }
    }
    
    // MARK: - Life cycle
    
    public init(configuration: TextFieldBasicConfiguration = .default()) {
        self._configuration = configuration
        super.init(frame: .zero)
        updateConfiguration(_configuration)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override var isEnabled: Bool {
        didSet {
            _state = isEnabled ? .normal : .disabled
        }
    }
    
    // MARK: - Position views
    
    public override var intrinsicContentSize: CGSize {
        guard let size = _configuration.size else {
            return super.intrinsicContentSize
        }
        return .init(width: .zero, height: size)
    }
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        return rect.inset(by: _configuration.textEdgeInsets ?? .zero)
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    // MARK: - Private
    
    private func updateConfiguration(_ configuration: TextFieldBasicConfiguration) {
        
        // Set corners
        if let corners = configuration.corners {
            self.corners = corners
        }
        
        // Set clearButtonMode
        if let clearButtonMode = configuration.clearButtonMode {
            self.clearButtonMode = clearButtonMode
        }
        
        updateStyle(_style)
        
        invalidateIntrinsicContentSize()
    }
    
    private func updateStyle(_ style: TextFieldBasicConfiguration.Style?) {
        
        guard let style else { return }
        
        // Set backgroundColor
        if let backgroundColor = style.backgroundColor {
            self.backgroundColor = backgroundColor
        }
        
        // Set borders
        if let borders = style.borders {
            self.borders = borders
        }
        
        // leftView
        if let view = style.leftView {
            self.leftView = view
        }
        
        // rightView
        if let view = style.rightView {
            self.rightView = view
        }
        
        // title
        if let style = style.textStyle {
            defaultTextAttributes = makeAttributes(color: style.color, font: style.font)
        }
        
        // placeholderStyles
        if let style = style.placeholderStyle {
            let attributes = makeAttributes(color: style.color, font: style.font)
            attributedPlaceholder = NSAttributedString(string: placeholder ?? "", attributes: attributes)
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

private extension TextFieldBasic {
    
    func makeAttributes(color: UIColor?, font: UIFont?) -> [NSAttributedString.Key : Any] {
        var attributes: [NSAttributedString.Key : Any] = [:]
        if let color { attributes[.foregroundColor] = color }
        if let font { attributes[.font] = font }
        return attributes
    }
}
