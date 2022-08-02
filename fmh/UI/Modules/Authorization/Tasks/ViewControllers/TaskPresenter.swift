//
//  TaskPresenter.swift
//  fmh
//
//  Created: 02.08.2022
//

import Foundation
import Combine

final class TaskPresenter {
    
    weak private var output: TaskPresenterOutput?
    
    var interactor: TaskInteractorProtocol?
    
    private var anyCancellable = Set<AnyCancellable>()

    var data: [Tasks] = [] {
        didSet {
            output?.updatedData(data)
        }
    }
    
    init(interactor: TaskInteractorProtocol, output: TaskPresenterOutput) {
        self.interactor = interactor
        self.output = output
    }
    
}

// MARK: - TaskPresenter
extension TaskPresenter: TaskPresenterInput {
    
    func getAllTasks() {
        interactor?.getAllTasks(completion: { tasks, networkError in
            guard networkError == nil else { return }
            
            if let tasks = tasks {
                self.data = tasks
            }
        })
    }
    
}
