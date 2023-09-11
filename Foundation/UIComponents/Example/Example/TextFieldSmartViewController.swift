
import UIKit
import UIComponents

final class TextFieldSmartViewController: UIViewController {
    
    // UI
    
    let stack: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 16
        $0.alignment = .fill
        $0.distribution = .equalSpacing
        return $0
    }(UIStackView())
    
    let scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.delaysContentTouches = false
        return $0
    }(UIScrollView())
    
    // MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "UIComponents.TextField"
        setupUI()
    }
    
    // MARK: Setup UI
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(stack)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            stack.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stack.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 32),
            stack.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -32),
            stack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stack.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -64)
        ])
        addTextFieldsInStack(stack)
    }
}

// MARK: - Buttons

private extension TextFieldSmartViewController {
    
    func addTextFieldsInStack(_ stack: UIStackView) {
        
        // MARK: TextFieldSmart.default
        let defaultLabel = UILabel()
        defaultLabel.text = "TextFieldSmart.default"
        defaultLabel.textAlignment = .center
        stack.addArrangedSubview(defaultLabel)
        
        let textFieldsSimple: [UIControl.State] = [
            .normal, .disabled, .focused, .warning, .error, .readOnly
        ]
        textFieldsSimple.enumerated().forEach {
            let input = TextFieldSmart(configuration: .default())
            input.tag = $0.offset
            input.setState($0.element)
            input.title = defaultLabel.text
            input.prompt = "Tag-\(input.tag)"
            input.text = $0.element.description
            input.placeholder = $0.element.description
            stack.addArrangedSubview(input)
        }
    }
}
