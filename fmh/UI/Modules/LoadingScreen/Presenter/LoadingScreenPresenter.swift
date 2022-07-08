//
//  LoadingScreenPresenter.swift
//  fmh
//
//  Created: 11.05.2022
//

import Foundation

class Presenter {
    
    weak private var viewInputDelegate: ViewInputDelegate?
    var testData = LoadingScreenModel.data
    
    func setViewInputDelegate(viewInputDelegate: ViewInputDelegate?) {
        self.viewInputDelegate = viewInputDelegate
    }
    
    private func loadTestData(){
        self.viewInputDelegate?.setupData(with: self.testData)
    }
    /*
    private func random(){
        let randomCount = Int.random(in: 0..<testData.count)
        self.viewInputDelegate?.displayData(i: randomCount)
    }
 */
}

extension Presenter: ViewOutputDelegate {
    /*
    func getRandomCount(){
        random()
    }
    */
    func getData() {
        self.loadTestData()
        self.viewInputDelegate?.setupInitialState()
    }
    
    func saveData() {
        
    }
}
