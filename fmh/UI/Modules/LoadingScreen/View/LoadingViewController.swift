//
//  LoadingViewController.swift
//  fmh
//
//  Created: 11.05.2022
//

import UIKit

protocol LoadingViewControllerProtocol: BaseViewProtocol {
    
}

class LoadingViewController: UIViewController, LoadingViewControllerProtocol {
    
    var onCompletion: (() -> ())?
    
    // MARK: Properties
    private let screen = UIScreen.main.bounds
    lazy var screenHeight = screen.size.height
    
    // MARK: Life cicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        view().setupLayout()
        view().constraintForLabel(viewHeight: screenHeight)
        
        /// Временно: Это типо когда данные загрузились нужно завершить текущий модуль
        /// Завершается через 5 сек и передает управление координатору
        DispatchQueue.main.asyncAfter(deadline: .now()+5.0) { [weak self] in
            self?.onCompletion?()
        }
        
    }
    
    override func loadView() {
        self.view = Layer()
    }
    
    func view() -> Layer {
       return self.view as! Layer
    }
}

