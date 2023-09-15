
import UIKit
import UIComponents

final class MoreViewController: UIViewController {
    
    // Dependencies
    private let presenter: MorePresenterProtocol
    
    // MARK: UI
    
    private var scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIScrollView())
    
    private var stackView: UIStackView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.axis = .vertical
        $0.spacing = 16.0
        $0.distribution = .equalSpacing
        $0.alignment = .fill
        return $0
    }(UIStackView())
    
    // MARK: - Life cycle
    
    init(
        presenter: MorePresenterProtocol
    ) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        presenter.setDelegate(self)
        commonInit()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Private
    
    private func commonInit() {
        view.backgroundColor = Color.background
        navigationItem.largeTitleDisplayMode = .always
        title = "Ещё"
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        scrollView.addSubview(stackView)
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16).isActive = true
        stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16).isActive = true
        stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -32).isActive = true
    }
}

// MARK: - MorePresenterDelegate

extension MoreViewController: MorePresenterDelegate {
    
    func insertCardView(_ view: UIView, at stackIndex: Int) {
        stackView.insertArrangedSubview(view, at: stackIndex)
    }
    
    func addArrangedSubview(_ view: UIView) {
        stackView.addArrangedSubview(view)
    }
}
