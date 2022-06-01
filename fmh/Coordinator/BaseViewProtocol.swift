//
//  BaseViewProtocol.swift
//  fmh
//
//  Created: 27.05.2022
//

import Foundation

protocol BaseViewProtocol: PresentableProtocol, AnyObject {
    var onCompletion: (() -> ())? { get set }
}
