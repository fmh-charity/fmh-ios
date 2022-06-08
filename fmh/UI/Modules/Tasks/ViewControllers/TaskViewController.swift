import UIKit

final class TaskViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    private var toolbarView = TopToolbarView()

    private lazy var  filerView: FilterVIew = {
        let view = FilterVIew()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        view.addSubview(filerView)

        toolbarView.settingsButton.addTarget(self, action: #selector(showFilters), for: .touchUpInside)
        filerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        filerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        filerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        filerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true

        collectionView.topAnchor.constraint(equalTo: toolbarView.bottomAnchor, constant: 14).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        toolbarView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        toolbarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        toolbarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        toolbarView.heightAnchor.constraint(equalToConstant: 55).isActive = true
        toolbarView.addButton.addTarget(self, action: #selector(addTask(_:)), for: .touchUpInside)
    }

    @objc func showFilters() {
        filerView.isHidden = false
    }
    
    @objc func addTask(_ sender: UIButton) {
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaskCollectionViewCell.reuseID,
                                                            for: indexPath) as? TaskCollectionViewCell else { return UICollectionViewCell()}
        let currentCell = taskModelCells[indexPath.row]
        cell.nameofThemeLabel.text = currentCell.nameOfTheme.russianHyphenated()
        cell.taskView.elementsView.nameOfExecutorLabel.text = currentCell.nameOfExecutor.russianHyphenated()
        cell.taskView.elementsView.dateLabel.text = currentCell.date
        cell.taskView.elementsView.timeLabel.text = currentCell.time
        return cell
    }

    // MARK: РАЗМЕР
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: UIScreen.main.bounds.width * 0.75, height: 200)
    }
    // MARK: КАК БУДЕТ ОТКРЫВАТЬСЯ ОКНО ПОЛНОЙ ИНФОРМАЦИИ О ЗАЯВКАХ?
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = TaskFullScreenViewController()
        vc.modalPresentationStyle = .formSheet
        self.present(vc, animated: true)
    }
}

