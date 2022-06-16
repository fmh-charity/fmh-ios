import UIKit

enum FilterClaim: String {
    case isOpened
    case isWorked
    case isCompleted
    case isClosed
}

final class TaskViewController: UIViewController, FilterDelegate {

    private var collectionView: UICollectionView?
    private var toolbarView = TopToolbarView()
    private lazy var filterVC = FilterViewController()
    var isFiltering = false
    var filteredArray = [DTOTask]()
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView?.reloadData()
    }

    func passData(dict: Dictionary<String, Bool>) {
        var array = [DTOTask]()
        for (key, value) in dict {
            if value {
                isFiltering = true
                switch key {
                case "Open":
                    array += taskModelCells.filter({ (cellModel:DTOTask) -> Bool in
                        return cellModel.status.contains("Open")})
                    print("Open")
                case "Work":
                     array += taskModelCells.filter({ (cellModel:DTOTask) -> Bool in
                        return cellModel.status.contains("Work")})
                    print("Work")
                case "Completed":
                    array += taskModelCells.filter { $0.status == "Completed" }
                    print("Completed")
                case "Canceled":
                    array += taskModelCells.filter { $0.status == "Canceled" }
                default: return
                }
            }
            collectionView?.reloadData()
        }
        print(filteredArray)
        filteredArray = []
        filteredArray = array
        print(filteredArray)
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
        popoverVC.filterDelegate = self
        self.present(popoverVC, animated: true, completion: nil)
    }
    @objc private func showFilters() {
        filterBlurEffect.isHidden = false
    }

    @objc private func addTask(_ sender: UIButton) {
        let vc = CreateTaskViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }

    @objc private func okFilter(_ sender: UIButton){
        filterBlurEffect.isHidden = true
    }

    @objc private func cancelFilter(_ sender: UIButton){
        filterBlurEffect.isHidden = true
    }
}

extension TaskViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering {
            return filteredArray.count
        }
        return taskModelCells.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaskCollectionViewCell.reuseID,for: indexPath) as? TaskCollectionViewCell else { return UICollectionViewCell() }
        var currentCell: DTOTask
        if isFiltering {
            currentCell = filteredArray[indexPath.row]
        } else {
            currentCell = taskModelCells[indexPath.row]
        }
        cell.nameofThemeLabel.text = currentCell.title.russianHyphenated()
        cell.taskView.elementsView.nameOfExecutorLabel.text = currentCell.creatorName.russianHyphenated()
        cell.taskView.elementsView.dateLabel.text = (formatDateFromIntToString(currentCell.planExecuteDate)).0
        cell.taskView.elementsView.timeLabel.text = (formatDateFromIntToString(currentCell.planExecuteDate)).1
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width * 0.75, height: 200)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = TaskFullScreenViewController()
        vc.model = taskModelCells[indexPath.row]
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
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

