import UIKit

final class TaskViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionViewLayout()
        view.backgroundColor = .white
    }
    
    private func collectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 40
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else {
            return
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TaskCollectionViewCell.self, forCellWithReuseIdentifier: TaskCollectionViewCell.reuseID)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
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
        CGSize(width: UIScreen.main.bounds.width * 0.75, height: 165)
    }

   
}

