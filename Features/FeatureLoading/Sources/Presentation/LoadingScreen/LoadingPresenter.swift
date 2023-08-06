//
//  LoadingPresenter.swift
//  
//
//  Created: 02.08.2023
//

import Foundation
import Core

protocol LoadingPresenterProtocol: AnyObject {
    func viewDidLoad()
}

protocol LoadingPresenterDelegate: AnyObject {
    func configure(_ model: LoadingViewController.Model)
}

final class LoadingPresenter {
    
    // Constants
    /// Минимальное время показа экрана (сек).
    static let minimumTimeShowing: Int = 1
    /// Период обновления экрана (сек).
    static let repeatingTimeShowing: Int = 10
    
    // Dependencies
    private let dataStorage: DataStorageProtocol
    private let view: LoadingPresenterDelegate
    var readyToComplete: (() -> Void)?
    
    private var data: [LoadingViewController.Model] = []
    private var timer: Timer?
    
    private var timerSteps: Int = 0 {
        didSet {
            if timerSteps > Self.minimumTimeShowing {
                readyToComplete?()
            }
            if timerSteps % Self.repeatingTimeShowing == 0 {
                update()
            }
        }
    }
    
    init(dataStorage: DataStorageProtocol, view: LoadingPresenterDelegate) {
        self.dataStorage = dataStorage
        self.view = view
        createTimer()
    }
    
    // MARK: - Update view
    
    private func update() {
        guard let itemData = data.randomElement() else {
            return
        }
        view.configure(.init(
            accentColor: itemData.accentColor,
            imageName: itemData.imageName,
            description: itemData.description)
        )
    }
    
    // MARK: - Timer
    
    private func createTimer() {
        guard timer == nil else { return }
        let timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(updateTimer),
            userInfo: nil,
            repeats: true
        )
        RunLoop.current.add(timer, forMode: .common)
        timer.tolerance = 0.1
        self.timer = timer
    }
    
    private func deleteTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func updateTimer() {
        timerSteps += 1
    }
}

// MARK: - LoadingPresenterProtocol

extension LoadingPresenter: LoadingPresenterProtocol {
    
    func viewDidLoad() {
        data = dataStorage.fetchData().map{ $0.viewModel }
        update()
    }
}
