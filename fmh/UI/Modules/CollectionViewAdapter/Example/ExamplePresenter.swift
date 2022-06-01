//
//  ExamplePresenter.swift
//  fmh
//
//  Created: 30.05.2022
//

import Foundation

final class ExamplePresenter {

    weak private var output: ExamplePresenterOutput?
    
    //var interactor: AuthInteractorProtocol?
    
    enum Section { case section1, section2 }
    var sections = Dictionary<Section, CollectionViewSection>()
    
    init(output: ExamplePresenterOutput) {
        self.output = output
        
        reloadSections()
    }
    
    private func reloadSections() {
        self.sections[.section1] = getSections1()
        self.sections[.section2] = getSections1()
    }
    
    private func getSections1() -> CollectionViewSection {
        let headerModel: ExampleHeader.Model = .init()
        let footerModel: ExampleFooter.Model = .init()
        
        //let itemModel: ExampleCell.Model = .init(titleLabel: "", descriptionLabel: "")
        let items: [CollectionViewSection.Item] = []
        
        /// Считываем interactorom items
        
        let section = CollectionViewSection (
            header: CollectionViewSection.Header(model: headerModel, viewType: ExampleHeader.self),
            items: items,
            footer: CollectionViewSection.Footer(model: footerModel, viewType: ExampleFooter.self)
        )
        
        return section
    }
    
}

// MARK: - GeneralPresenterInput
extension ExamplePresenter: ExamplePresenterInput {

    func updateSections(_ section: Section? = nil) {
        switch section {
            case .section1:
                self.sections.updateValue(getSections1(), forKey: .section1)
            // updateSection in collectionView
            case .section2:
                self.sections.updateValue(getSections1(), forKey: .section2)
            // updateSection in collectionView
        case .none:
            reloadSections()
            // reload in collectionView
        }
    }
    
}
