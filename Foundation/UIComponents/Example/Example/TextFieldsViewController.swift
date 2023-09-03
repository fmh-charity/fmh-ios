
import UIKit
import UIComponents

final class TextFieldsViewController: UIViewController {
    
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

private extension TextFieldsViewController {
    
    func addTextFieldsInStack(_ stack: UIStackView) {
        
        // MARK: Default textFields
        let defaultLabel = UILabel()
        defaultLabel.text = "Default textFields"
        defaultLabel.textAlignment = .center
        stack.addArrangedSubview(defaultLabel)
        let defaultTextField = TextField(configuration: .default())
        defaultTextField.isEnabled = false
        stack.addArrangedSubview(defaultTextField)
        stack.addArrangedSubview(TextField(configuration: .default()))
        
        // MARK: Search textFields
        let searchLabel = UILabel()
        searchLabel.text = "Search textFields"
        searchLabel.textAlignment = .center
        stack.addArrangedSubview(searchLabel)
        let searchTextField = TextField(configuration: .search.default())
        searchTextField.isEnabled = false
        stack.addArrangedSubview(searchTextField)
        stack.addArrangedSubview(TextField(configuration: .search.default()))
        
        // MARK: TextFieldSimple textFields
        let textFieldSimpleLabel = UILabel()
        textFieldSimpleLabel.text = "TextFieldSimple textFields"
        textFieldSimpleLabel.textAlignment = .center
        stack.addArrangedSubview(textFieldSimpleLabel)
        
        let textFieldsSimple: [TextFieldWithState.State] = [
            .normal, .disabled, .focused, .warning, .error, .readOnly
        ]
        textFieldsSimple.enumerated().forEach {
            let input = TextFieldPasswordWithState(configuration: .default)
            input.tag = $0
            input.textFieldState = $1
            input.title = "Tag: \($0)"
            input.prompt = "Prompt - \($0)"
            input.text = $1.rawValue
            stack.addArrangedSubview(input)
        }
    }
}
