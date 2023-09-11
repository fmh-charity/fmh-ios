
import UIKit
import UIComponents

final class ButtonsViewController: UIViewController {
    
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
        title = "UIComponents.Button"
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
        addButtonsInStack(stack)
    }
    
    
}

// MARK: - Buttons

private extension ButtonsViewController {
    
    func addButtonsInStack(_ stack: UIStackView) {
        
        // MARK: Default buttons
        let defaultLabel = UILabel()
        defaultLabel.text = "Default buttons"
        defaultLabel.textAlignment = .center
        stack.addArrangedSubview(defaultLabel)
        let defaultButtonDisabled = Button(configuration: .default())
        defaultButtonDisabled.setState(.disabled)
        defaultButtonDisabled.title =  defaultLabel.text
        stack.addArrangedSubview(defaultButtonDisabled)
        let defaultButton = Button(configuration: .default())
        defaultButton.title =  defaultLabel.text
        stack.addArrangedSubview(defaultButton)
        
        // MARK: Primary buttons
        let primaryLabel = UILabel()
        primaryLabel.text = "Primary buttons"
        primaryLabel.textAlignment = .center
        stack.addArrangedSubview(primaryLabel)
        let primaryButtonDisabled = Button(configuration: .primary())
        primaryButtonDisabled.setState(.disabled)
        primaryButtonDisabled.title =  primaryLabel.text
        stack.addArrangedSubview(primaryButtonDisabled)
        let primaryButton = Button(configuration: .primary())
        primaryButton.title =  primaryLabel.text
        stack.addArrangedSubview(primaryButton)
        
        // MARK: Secondary buttons
        let secondaryLabel = UILabel()
        secondaryLabel.text = "Secondary buttons"
        secondaryLabel.textAlignment = .center
        stack.addArrangedSubview(secondaryLabel)
        let secondaryButtonDisabled = Button(configuration: .secondary())
        secondaryButtonDisabled.title = secondaryLabel.text
        secondaryButtonDisabled.setState(.disabled)
        stack.addArrangedSubview(secondaryButtonDisabled)
        let secondaryButton = Button(configuration: .secondary())
        secondaryButton.title = secondaryLabel.text
        stack.addArrangedSubview(secondaryButton)
    }
}
