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
    var sections = Dictionary<Section, CollectionViewSection>() {
        didSet {
            let sections = sections.map { $1 }
            output?.updateCollectionView(sections: sections)
        }
    }
    
    /// Section name
    var section1: CollectionViewSection = {
        let headerModel: ExampleHeader.Model = .init()
        let footerModel: ExampleFooter.Model = .init()

        let items: [CollectionViewSection.Item] = []

        let section = CollectionViewSection (
            header: CollectionViewSection.Header(model: headerModel, viewType: ExampleHeader.self),
            items: items,
            footer: CollectionViewSection.Footer(model: footerModel, viewType: ExampleFooter.self)
        )
        
        return section
    }()
    
    init(output: ExamplePresenterOutput) {
        self.output = output
        
        reloadSections()
    }
    
    private func reloadSections() {
        self.sections[.section1] = section1
        self.sections[.section2] = section1
    }
    
    private func loadSections1() {
        
    }
    
}

// MARK: - GeneralPresenterInput
extension ExamplePresenter: ExamplePresenterInput {

    func updateSections(_ section: Section? = nil) {
        switch section {
            case .section1:
                self.sections.updateValue(section1, forKey: .section1)
            // updateSection in collectionView
            case .section2:
                self.sections.updateValue(section1, forKey: .section2)
            // updateSection in collectionView
        case .none:
            reloadSections()
            // reload in collectionView
        }
    }
    
}
