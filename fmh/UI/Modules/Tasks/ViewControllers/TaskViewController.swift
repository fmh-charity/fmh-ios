import UIKit

enum FilterClaim: String {
    case isOpened
    case isWorked
    case isCompleted
    case isClosed
}

final class TaskViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    private var toolbarView = TopToolbarView()
    private lazy var filterVC = FilterViewController()
    private lazy var filterBlurEffect: BackgroundBlurFilterView = {
        let blurEffect = BackgroundBlurFilterView()
        blurEffect.isHidden = true
        blurEffect.translatesAutoresizingMaskIntoConstraints = false
        return blurEffect
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewLayout()
        view.backgroundColor = .white
        takeActionFromFilter()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }
    
    private func collectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 40
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TaskCollectionViewCell.self, forCellWithReuseIdentifier: TaskCollectionViewCell.reuseID)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        view.addSubview(toolbarView)
        view.addSubview(filterBlurEffect)
        
        toolbarView.settingsButton.addTarget(self, action: #selector(showFilters(_:)), for: .touchUpInside)
        toolbarView.addButton.addTarget(self, action: #selector(addTask(_:)), for: .touchUpInside)
        
        let constraints = [
            filterBlurEffect.topAnchor.constraint(equalTo: view.topAnchor),
            filterBlurEffect.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            filterBlurEffect.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            filterBlurEffect.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            collectionView.topAnchor.constraint(equalTo: toolbarView.bottomAnchor, constant: 14),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            toolbarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            toolbarView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbarView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolbarView.heightAnchor.constraint(equalToConstant: 55),
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc private func showFilters(_ sender: UIButton) {
        let popoverVC = FilterViewController()
        popoverVC.modalPresentationStyle = .popover
        popoverVC.preferredContentSize = CGSize(width: UIScreen.main.bounds.width * 0.9, height: 300)
        popoverVC.popoverPresentationController?.sourceView = sender
        popoverVC.popoverPresentationController?.permittedArrowDirections = .up
        popoverVC.popoverPresentationController?.delegate = self
        self.present(popoverVC, animated: true, completion: nil)
    }
    
    @objc private func addTask(_ sender: UIButton) {
        let vc = CreateTaskViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}

extension TaskViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        taskModelCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaskCollectionViewCell.reuseID,for: indexPath) as? TaskCollectionViewCell else { return UICollectionViewCell() }
        let currentCell = taskModelCells[indexPath.row]
        cell.nameofThemeLabel.text = currentCell.nameOfTheme.russianHyphenated()
        cell.taskView.elementsView.nameOfExecutorLabel.text = currentCell.nameOfExecutor.russianHyphenated()
        cell.taskView.elementsView.dateLabel.text = currentCell.date
        cell.taskView.elementsView.timeLabel.text = currentCell.time
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width * 0.75, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = TaskFullScreenViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    //MARK: доделать филтрацию
    func takeActionFromFilter() {
        filterVC.filterComplition = {[weak self] result in
          
        }
    }
}

extension TaskViewController: UIPopoverPresentationControllerDelegate {
    public func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}

class PopoverViewController: UIViewController {
    override func viewDidLoad() {
        self.view.backgroundColor = .systemGray
        self.preferredContentSize = CGSize(width: 300, height: 200)
    }
}

