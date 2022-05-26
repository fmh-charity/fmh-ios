//
//  GeneralViewController.swift
//  fmh
//
//  Created: 25.05.2022
//
//  https://github.com/johncodeos-blog/CustomSideMenuiOSExample/tree/main/CustomSideMenuiOSExample

import Foundation
import UIKit

class GeneralViewController: UIViewController {
    
    var presenter: GeneralPresenterInput?
    weak var contextViewController: UIViewController?
    
    private var sideMenuViewController: SideMenuViewController = {
        let viewController = SideMenuViewController()
        
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        return viewController
    }()
    
    private var sideMenuShadowView: UIView!
    
    private var sideMenuRevealWidth: CGFloat = 260
    private let paddingForRotation: CGFloat = 150
    private var isExpanded: Bool = false
    private var draggingIsEnabled: Bool = false
    private var panBaseLocation: CGFloat = 0.0
    
    private var sideMenuTrailingConstraint: NSLayoutConstraint!

    private var revealSideMenuOnTop: Bool = true
    
    var gestureEnabled: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground

        /// Shadow Background View
        self.sideMenuShadowView = UIView(frame: self.view.bounds)
        self.sideMenuShadowView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.sideMenuShadowView.backgroundColor = .black
        self.sideMenuShadowView.alpha = 0.0
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapGestureRecognizer))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.delegate = self
        view.addGestureRecognizer(tapGestureRecognizer)
        if self.revealSideMenuOnTop {
            view.insertSubview(self.sideMenuShadowView, at: 1)
        }

        /// Add sideMenuViewController
        self.sideMenuViewController.defaultHighlightedCell = 0 
        self.sideMenuViewController.delegate = self
        view.insertSubview(self.sideMenuViewController.view, at: self.revealSideMenuOnTop ? 2 : 0)
        addChild(self.sideMenuViewController)
        self.sideMenuViewController.didMove(toParent: self)

        /// sideMenuViewController AutoLayout
        if self.revealSideMenuOnTop {
            self.sideMenuTrailingConstraint = self.sideMenuViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -self.sideMenuRevealWidth - self.paddingForRotation)
            self.sideMenuTrailingConstraint.isActive = true
        }
        NSLayoutConstraint.activate([
            self.sideMenuViewController.view.widthAnchor.constraint(equalToConstant: self.sideMenuRevealWidth),
            self.sideMenuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.sideMenuViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
        ])

        /// sideMenuViewController Gestures
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGestureRecognizer.delegate = self
        view.addGestureRecognizer(panGestureRecognizer)

        /// Default  View Controller
        if let viewController = contextViewController {
            showViewController(viewController: viewController)
        } else {
            // TODO: Экран заглушка нужен
            let viewController = UIViewController()
            viewController.view.backgroundColor = .green
            
            showViewController(viewController: viewController)
        }
        
    }

    ///  Show menu in other (chlds) viewControllers
    @objc open func revealSideMenu() {
        self.sideMenuState(expanded: self.isExpanded ? false : true)
    }
    
    func animateShadow(targetPosition: CGFloat) {
        UIView.animate(withDuration: 0.5) {
            // When targetPosition is 0, which means side menu is expanded, the shadow opacity is 0.6
            self.sideMenuShadowView.alpha = (targetPosition == 0) ? 0.6 : 0.0
        }
    }

    func sideMenuState(expanded: Bool) {
        if expanded {
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? 0 : self.sideMenuRevealWidth) { _ in
                self.isExpanded = true
            }
            // Animate Shadow (Fade In)
            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.6 }
        }
        else {
            self.animateSideMenu(targetPosition: self.revealSideMenuOnTop ? (-self.sideMenuRevealWidth - self.paddingForRotation) : 0) { _ in
                self.isExpanded = false
            }
            // Animate Shadow (Fade Out)
            UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = 0.0 }
        }
    }
    
    func animateSideMenu(targetPosition: CGFloat, completion: @escaping (Bool) -> ()) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .layoutSubviews, animations: {
            if self.revealSideMenuOnTop {
                self.sideMenuTrailingConstraint.constant = targetPosition
                self.view.layoutIfNeeded()
            }
            else {
                self.view.subviews[1].frame.origin.x = targetPosition
            }
        }, completion: completion)
    }

//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
}

// MARK: - GeneralPresenterOutput
extension GeneralViewController: GeneralPresenterOutput {

}

//MARK: - SideMenuViewControllerDelegate
extension GeneralViewController: SideMenuViewControllerDelegate {
    
    func didSelect(indexPath: IndexPath) {
        if indexPath.section == 0 {
            let itemMenu = SideMenuViewController.MenuOptions.allCases[indexPath.row]
            switch itemMenu {
            case .home: showViewController(viewController: TemplateViewController())
                //  showViewController(viewController: GeneralContextViewController())
            default: break
            }
        }
        if indexPath.section == 1 {
            let itemMenu = SideMenuViewController.AdditionalMenuOptions.allCases[indexPath.row]
            switch itemMenu {
            case .settings: break
            case .logOut: presenter?.logOut()
            }
        }
        DispatchQueue.main.async { self.sideMenuState(expanded: false) }
    }

    func showViewController<T: UIViewController>(viewController: T) -> () {
        // Remove the previous View
        for subview in view.subviews {
            if subview.tag == 99 {
                subview.removeFromSuperview()
            }
        }
        
        viewController.view.tag = 99
        view.insertSubview(viewController.view, at: self.revealSideMenuOnTop ? 0 : 1)
        addChild(viewController)
        viewController.view.frame = self.view.bounds

        if !self.revealSideMenuOnTop {
            if isExpanded {
                viewController.view.frame.origin.x = self.sideMenuRevealWidth
            }
            if self.sideMenuShadowView != nil {
                viewController.view.addSubview(self.sideMenuShadowView)
            }
        }
        viewController.didMove(toParent: self)
    }
}

//MARK: - UIGestureRecognizerDelegate
extension GeneralViewController: UIGestureRecognizerDelegate {
    
    @objc func tapGestureRecognizer(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            if self.isExpanded {
                self.sideMenuState(expanded: false)
            }
        }
    }

    // Close side menu when you tap on the shadow background view
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if (touch.view?.isDescendant(of: self.sideMenuViewController.view))! {
            return false
        }
        return true
    }
    
    // Dragging Side Menu
    @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
        
        guard gestureEnabled == true else { return }

        let position: CGFloat = sender.translation(in: self.view).x
        let velocity: CGFloat = sender.velocity(in: self.view).x

        switch sender.state {
        case .began:

            // If the user tries to expand the menu more than the reveal width, then cancel the pan gesture
            if velocity > 0, self.isExpanded {
                sender.state = .cancelled
            }

            // If the user swipes right but the side menu hasn't expanded yet, enable dragging
            if velocity > 0, !self.isExpanded {
                self.draggingIsEnabled = true
            }
            // If user swipes left and the side menu is already expanded, enable dragging
            else if velocity < 0, self.isExpanded {
                self.draggingIsEnabled = true
            }

            if self.draggingIsEnabled {
                // If swipe is fast, Expand/Collapse the side menu with animation instead of dragging
                let velocityThreshold: CGFloat = 550
                if abs(velocity) > velocityThreshold {
                    self.sideMenuState(expanded: self.isExpanded ? false : true)
                    self.draggingIsEnabled = false
                    return
                }

                if self.revealSideMenuOnTop {
                    self.panBaseLocation = 0.0
                    if self.isExpanded {
                        self.panBaseLocation = self.sideMenuRevealWidth
                    }
                }
            }

        case .changed:
            if self.draggingIsEnabled {
                if self.revealSideMenuOnTop {
                    // Show/Hide shadow background view while dragging
                    let xLocation: CGFloat = self.panBaseLocation + position
                    let percentage = (xLocation * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth

                    let alpha = percentage >= 0.6 ? 0.6 : percentage
                    self.sideMenuShadowView.alpha = alpha

                    // Move side menu while dragging
                    if xLocation <= self.sideMenuRevealWidth {
                        self.sideMenuTrailingConstraint.constant = xLocation - self.sideMenuRevealWidth
                    }
                }
                else {
                    if let recogView = sender.view?.subviews[1] {
                        // Show/Hide shadow background view while dragging
                        let percentage = (recogView.frame.origin.x * 150 / self.sideMenuRevealWidth) / self.sideMenuRevealWidth

                        let alpha = percentage >= 0.6 ? 0.6 : percentage
                        self.sideMenuShadowView.alpha = alpha

                        // Move side menu while dragging
                        if recogView.frame.origin.x <= self.sideMenuRevealWidth, recogView.frame.origin.x >= 0 {
                            recogView.frame.origin.x = recogView.frame.origin.x + position
                            sender.setTranslation(CGPoint.zero, in: view)
                        }
                    }
                }
            }
        case .ended:
            self.draggingIsEnabled = false
            // If the side menu is half Open/Close, then Expand/Collapse with animation
            if self.revealSideMenuOnTop {
                let movedMoreThanHalf = self.sideMenuTrailingConstraint.constant > -(self.sideMenuRevealWidth * 0.5)
                self.sideMenuState(expanded: movedMoreThanHalf)
            }
            else {
                if let recogView = sender.view?.subviews[1] {
                    let movedMoreThanHalf = recogView.frame.origin.x > self.sideMenuRevealWidth * 0.5
                    self.sideMenuState(expanded: movedMoreThanHalf)
                }
            }
        default:
            break
        }
    }
}

//MARK: - revealViewController
extension UIViewController {
    func revealViewController() -> GeneralViewController? {
        var viewController: UIViewController? = self
        
        if viewController != nil && viewController is GeneralViewController {
            return viewController! as? GeneralViewController
        }
        while (!(viewController is GeneralViewController) && viewController?.parent != nil) {
            viewController = viewController?.parent
        }
        if viewController is GeneralViewController {
            return viewController as? GeneralViewController
        }
        return nil
    }
}
