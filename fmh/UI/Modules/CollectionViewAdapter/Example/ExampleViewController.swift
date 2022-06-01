//
//  ExampleViewController.swift
//  fmh
//
//  Created: 30.05.2022
//

import UIKit

class ExampleViewController: UIViewController, ExampleViewControllerProtocol {
    
    typealias Section = CollectionViewSection
    
    var presenter: ExamplePresenterInput?
    var onCompletion: (() -> ())?
    
    private var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout() // <- Перенести в класс
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 0
        
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collection.backgroundColor = .lightGray
        collection.allowsMultipleSelection = true
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.alwaysBounceVertical = true
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    lazy private var collectionViewAdapter: CollectionViewAdapter = {
        let collectionViewAdapter = CollectionViewAdapter(collectionView: self.collectionView)
        collectionViewAdapter.delegate = self

        return collectionViewAdapter
    }()
    
    struct TestModel {
        let title: String
        let text: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        title = "Example CollectionView adapter"

        setLayouts()
        
        setNavigationBarMenuButton()
        
        collectionView.delegate = collectionViewAdapter
        collectionView.dataSource = collectionViewAdapter
        
        // model
        
        
        let models:[TestModel] = [
        TestModel(title: "Test-0", text: "jbjekrjg ekjgkejg ekjg ekj gekrjg kerjg ekjrg kejr gkejr gker kejg"),
        TestModel(title: "Test-0", text: "jbjekrjg ekjg kejr gkejr gker kejg"),
        TestModel(title: "Test-0", text: """
                    jbjekrjg ekjgkejg ekjg ekj gekrjg wefw f ef w
                    wefwef wef we fw f we f we f we f w ef we f we fw ef w ef
                    wefwef w ef we f we f wef we f wefwefwefwef we f wef
                    w efwefwef we f we f we fw ef wefwekerjg ekjrg kejr gkejr gker kejg
                    """)
        ]
        
        // Sections
        let sections: [Section] = [
          Section(
            header: Section.Header(model: String("HEADER"), viewType: ExampleHeader.self),
            items: [
                Section.Item(model: models[0], viewType: ExampleCell.self),
                Section.Item(model: models[1], viewType: ExampleCell.self),
                Section.Item(model: models[2], viewType: ExampleCell.self)
            ]
          )
        ]

        collectionViewAdapter.sections = sections
        
    }
    
    /// Нужны для отключения свайпа (Открытия меню)
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.revealViewController()?.gestureEnabled = false
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.revealViewController()?.gestureEnabled = true
//    }
     
    private func setLayouts() {
        
        let margins = view.layoutMarginsGuide
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: margins.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: margins.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: margins.trailingAnchor)
        ])
        
    }
    
}

// MARK: - TemplatePresenterOutput
extension ExampleViewController: ExamplePresenterOutput {

}

// MARK: - TemplatePresenterOutput
extension ExampleViewController: CollectionViewAdapterDelegate {
    
    func configure(model: Any, view: UICollectionReusableView, indexPath: IndexPath) {
        
        guard let model = model as? ExampleViewController.TestModel else { return }
        
        if let cell = view as? ExampleCell {
            cell.configure(model: .init(titleLabel: model.title, descriptionLabel: model.text))
        }

    }
    
    func didSelect(model: Any, indexPath: IndexPath) {
        collectionView.performBatchUpdates(nil)
    }
    
    func didDeselect() {
        collectionView.performBatchUpdates(nil)
    }
    
    func sizeCell(item: CollectionViewSection.Item, collectionView: UICollectionView, indexPath: IndexPath) -> CGSize {
        let referenceHeight: CGFloat = 200 // Approximate height of your cell
        let referenceWidth = collectionView.referenceWidth()
        return CGSize(width: referenceWidth, height: referenceHeight)
    }
    
    func sizeHeader(header: CollectionViewSection.Header, collectionView: UICollectionView, section: Int) -> CGSize {
        return .init(width: collectionView.referenceWidth(), height: 60)
    }
    
    func sizeFooter(footer: CollectionViewSection.Footer, collectionView: UICollectionView, section: Int) -> CGSize {
        return .init(width: collectionView.referenceWidth(), height: 70)
    }
    
}

//MARK: - ReferenceWidth
extension UICollectionView {
    
    func referenceWidth() -> CGFloat {
        guard let sectionInset = (self.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset else {
            return .zero
        }
        let referenceWidth = self.safeAreaLayoutGuide.layoutFrame.width
        - sectionInset.left
        - sectionInset.right
        - self.contentInset.left
        - self.contentInset.right
        
        return referenceWidth
    }
    
}
