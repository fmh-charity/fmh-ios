//
//  LoadingPresenter.swift
//  
//
//  Created: 02.08.2023
//

import Foundation
import UIKit

protocol LoadingPresenterProtocol: AnyObject {
    func viewDidLoad()
}

protocol LoadingPresenterDelegate: AnyObject, UIViewController {
    func configure(_ model: LoadingViewController.Model)
}

// MARK: Constants
private extension Int {
    /// Минимальное время показа экрана (сек).
    static let minimumTimeShowing: Int = 1
    /// Период обновления экрана (сек).
    static let repeatingTimeShowing: Int = 10
    /// Таймаут проверки сети  (сек).
    static let timeoutCheckNetwork: Int = 60
}

final class LoadingPresenter {
    
    // Dependencies
    private let dataStorage: DataStorageProtocol
    private let reachability: ReachabilityProtocol
    weak var delegate: LoadingPresenterDelegate?
    var onCompletion: (() -> Void)?
    
    private var data: [LoadingViewController.Model] = []
    private var timer: Timer?
    
    private var timerSteps: Int = 0 {
        didSet {
            checkNetwork(timerSteps: timerSteps)
        }
    }
    
    init(
        dataStorage: DataStorageProtocol,
        reachability: ReachabilityProtocol
    ) {
        self.dataStorage = dataStorage
        self.reachability = reachability
        createTimer()
    }
    
    // MARK: - Update view
    
    private func update() {
        guard let itemData = data.randomElement() else {
            return
        }
        delegate?.configure(
            .init(
                accentColor: itemData.accentColor,
                imageName: itemData.imageName,
                description: itemData.description
            )
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
    
    // MARK: - Check network
    
    private func checkNetwork(timerSteps: Int) {
        // Если все ок
        if
            timerSteps > .minimumTimeShowing,
            reachability.checkNetwork()
        {
            deleteTimer()
            onCompletion?()
        }
        // Если нет сети по таймауту.
        if timerSteps >= .timeoutCheckNetwork {
            showAlert()
            deleteTimer()
        }
        // Смена каждые 10 сек.
        if (timerSteps % .repeatingTimeShowing) == 0 {
            update()
        }
    }
    
    // MARK: - Show alert
    
    private func showAlert() {
        let errorStr = "При загрузке приложения произошла ошибка.\nПопробуйте перезагрузить приложение!"
        delegate?.showAlert(title: "Ошибка", message: errorStr) { [weak self] _ in
            self?.timerSteps = 0
            self?.createTimer()
        }
    }
}

// MARK: - LoadingPresenterProtocol

extension LoadingPresenter: LoadingPresenterProtocol {
    
    func viewDidLoad() {
        data = dataStorage.fetchData().map{ $0.viewModel }
        update()
    }
}
