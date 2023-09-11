
import UIKit
import UIComponents

final class TextFieldBasicViewController: UIViewController {
    
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

private extension TextFieldBasicViewController {
    
    func addTextFieldsInStack(_ stack: UIStackView) {
        
        // MARK: TextFieldBasic.default
        let defaultLabel = UILabel()
        defaultLabel.text = "TextFieldBasic.default"
        defaultLabel.textAlignment = .center
        stack.addArrangedSubview(defaultLabel)
        let defaultTextFieldDisable = TextFieldBasic(configuration: .default())
        defaultTextFieldDisable.setState(.disabled)
        defaultTextFieldDisable.placeholder = defaultLabel.text
        stack.addArrangedSubview(defaultTextFieldDisable)
        let defaultTextField = TextFieldBasic(configuration: .default())
        defaultTextField.placeholder = defaultLabel.text
        stack.addArrangedSubview(defaultTextField)
        
        // MARK: TextFieldBasic.search
        let searchLabel = UILabel()
        searchLabel.text = "TextFieldSmart.search"
        searchLabel.textAlignment = .center
        stack.addArrangedSubview(searchLabel)
        let searchTextFieldDisable = TextFieldBasic(configuration: .search())
        searchTextFieldDisable.setState(.disabled)
        searchTextFieldDisable.placeholder = searchLabel.text
        stack.addArrangedSubview(searchTextFieldDisable)
        let searchTextField = TextFieldBasic(configuration: .search())
        searchTextField.placeholder = defaultLabel.text
        stack.addArrangedSubview(searchTextField)
    }
}
