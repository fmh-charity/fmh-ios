//
//  NewsCustomClasses.swift
//  fmh
//
//  Created: 23.12.2022
//

import UIKit

//MARK: - TextField с отключенной вставкой

class NoPasteUITextField: UITextField {
   override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
   }
}
