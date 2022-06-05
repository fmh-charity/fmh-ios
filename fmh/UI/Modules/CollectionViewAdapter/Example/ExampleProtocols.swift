//
//  ExampleProtocols.swift
//  fmh
//
//  Created: 30.05.2022
//

import Foundation

// MARK: - ExamplePresenterInput
protocol ExamplePresenterInput: AnyObject {

}

// MARK: - ExamplePresenterOutput
protocol ExamplePresenterOutput: AnyObject {
    var presenter: ExamplePresenterInput? { get set }
    
    func updateCollectionView(sections: [CollectionViewSection])
}

// MARK: - ExampleViewControllerProtocol
protocol ExampleViewControllerProtocol: BaseViewProtocol {
    
}
