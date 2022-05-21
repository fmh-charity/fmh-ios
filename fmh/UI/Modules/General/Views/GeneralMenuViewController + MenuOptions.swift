//
//  GeneralMenuViewController + MenuOptions.swift
//  fmh
//
//  Created: 21.05.2022
//

import Foundation
import UIKit

extension GeneralMenuViewController {
    
    enum MenuOptions: String, CaseIterable {
        case home = "Home"
        case other = "Other"
        
        var image: UIImage? {
            switch self {
            case .home:
                return UIImage(systemName: "phone")
            case .other:
                return UIImage(systemName: "person")
            }
        }
    }
    
}
