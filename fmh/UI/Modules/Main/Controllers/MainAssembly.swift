//
//  MainAssembly.swift
//  fmh
//
//  Created: 10.05.2022
//

import Foundation

final class MainAssembly {
    
    static func assembly(with output: MainPresenterOutput) {
        
        let presenter  = MainPresenter()
        
        presenter.output     = output
        output.presenter     = presenter
    }
    
}
