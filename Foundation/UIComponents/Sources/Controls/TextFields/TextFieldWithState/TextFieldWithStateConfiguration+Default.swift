//
//  File.swift
//  
//
//  Created by Константин Туголуков on 03.09.2023.
//

import Foundation

extension TextFieldWithStateConfiguration {
    
    /*
     Конфигурация по умолчанию.
     */
    public static let `default`: TextFieldWithStateConfiguration = {
        .init(
            contentEdgeInsets: .init(top: 16, left: 12, bottom: 16, right:  32),
            borderLayerEdgeInsets: .init(top: 4, left: 0, bottom: 2, right:  0),
            borderCornerRadius: 8.0,
            clearButtonMode: .always,
            clearButtonOffsetX: -6.0
        )
    }()
}
