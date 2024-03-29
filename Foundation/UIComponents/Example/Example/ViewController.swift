
import UIKit
import UIComponents

final class ViewController: UIViewController {
    
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
        title = "UIComponents"
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
        
        // MARK: Button
        let buttonsButton = Button(configuration: .default())
        buttonsButton.title = "Button"
        buttonsButton.addTarget(self, action: #selector(buttonsButtonAction), for: .touchUpInside)
        stack.addArrangedSubview(buttonsButton)
        
        // MARK: textFieldsBase
        let textFieldsBase = Button(configuration: .default())
        textFieldsBase.title = "textFieldsBase"
        textFieldsBase.addTarget(self, action: #selector(textFieldsBaseAction), for: .touchUpInside)
        stack.addArrangedSubview(textFieldsBase)
        
        // MARK: textFieldsSmart
        let textFieldsSmart = Button(configuration: .default())
        textFieldsSmart.title = "textFieldsSmart"
        textFieldsSmart.addTarget(self, action: #selector(textFieldsSmartAction), for: .touchUpInside)
        stack.addArrangedSubview(textFieldsSmart)
    }
    
    // MARK: - Actions
    
    @objc private func buttonsButtonAction() {
        let viewController = ButtonsViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func textFieldsBaseAction() {
        let viewController = TextFieldBasicViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    @objc private func textFieldsSmartAction() {
        let viewController = TextFieldSmartViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}
