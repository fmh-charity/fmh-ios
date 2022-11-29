//
//  CombainTet.swift
//  fmh
//
//  Created: 29.11.2022
//

import Foundation
import Combine

class TestCombain {
    
    struct Article: Codable {
        let title: String
        let author: String
    }
    
    func test() {
        let data = PassthroughSubject<Article, Never>()
        
        let canc = data
            .encode(encoder: JSONEncoder())
            
    }
}
