//
//  DataModel+ViewModel.swift
//  
//
//  Created by Константин Туголуков on 05.08.2023.
//

import UIKit

struct DataModel {
    let colorHex: String
    let imageName: String
    let description: String
}

// MARK: - Convert to view model

extension DataModel {
    
    var viewModel: LoadingViewController.Model {
        .init(
            accentColor: UIColor(hex: self.colorHex),
            imageName: self.imageName,
            description: self.description
        )
    }
}
