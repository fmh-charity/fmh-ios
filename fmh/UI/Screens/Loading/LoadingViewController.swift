//
//  LoadingViewController.swift
//  fmh
//
//  Created: 26.11.2022
//

import Foundation

protocol LoadingViewControllerProtocol: BaseViewControllerProtocol {
//    var onInfo: CompletionBlock? { get set }
}


final class LoadingViewController: BaseViewController, LoadingViewControllerProtocol {
    
    // Когда все сервисы завершились. (прилетает от координатора)
    var loadingServiceComplition: Bool?
    
    private var timer: Timer?
    
    private var countShows: Int = 0 {
        didSet {
            if loadingServiceComplition ?? false && countShows > 0 {
                self.deleteTimer()
                self.onCompletion?()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        view.backgroundColor = .orange
        
        createTimer()
    }
    
    private func createTimer() {
        guard timer == nil else { return }
        
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        RunLoop.current.add(timer, forMode: .common)
        timer.tolerance = 0.1
        
        self.timer = timer
    }
    
    private func deleteTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func updateTimer() {
        countShows += 1
    }
    
}
