//
//  TaskProtocols.swift
//  fmh
//
//  Created: 02.08.2022
//

import Foundation

// MARK: - TaskPresenterInput
protocol TaskPresenterInput: AnyObject {
    var data: [Tasks] {get set}
    
    func getAllTasks()

}


// MARK: - TaskPresenterOutput
protocol TaskPresenterOutput: AnyObject {
    var presenter: TaskPresenterInput? { get set }
    
    func updatedData(_ data: [Tasks])
}

// MARK: - TaskViewControllerProtocol
protocol TaskViewControllerProtocol: BaseViewProtocol {
    
}
