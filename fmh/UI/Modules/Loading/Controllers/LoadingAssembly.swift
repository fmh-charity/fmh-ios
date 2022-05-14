//
//  LoadingAssembly.swift
//  fmh
//
//  Created: 14.05.2022
//

import Foundation

final class LoadingAssembly {
    
    static func assembly(with output: LoadingPresenterOutput) {
        
        let presenter  = LoadingPresenter()
        
        presenter.output     = output
        output.presenter     = presenter
    }
    
}
