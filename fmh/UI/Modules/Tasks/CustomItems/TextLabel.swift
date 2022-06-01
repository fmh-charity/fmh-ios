//
//  TextLabel.swift
//  fmh
//
//  Created: 24.05.2022
//

import UIKit

extension UILabel {
    convenience init(text: String?, font: UIFont?, tintColor: UIColor, textAlignment: NSTextAlignment) {
        self.init(frame: CGRect())
        self.text = text
        self.font = font
        self.tintColor = tintColor
        self.textColor = tintColor
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = textAlignment
        self.backgroundColor = .clear
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = 0
    }
}

extension String {

func russianHyphenated() -> String {
    return hyphenated(locale: Locale(identifier: "ru_Ru"))
}

func hyphenated(languageCode: String) -> String {
    let locale = Locale(identifier: languageCode)
    return self.hyphenated(locale: locale)
}

func hyphenated(locale: Locale) -> String {
    guard CFStringIsHyphenationAvailableForLocale(locale as CFLocale) else { return self }
    
    var s = self
    
    let fullRange = CFRangeMake(0, s.utf16.count)
    var hyphenationLocations = [CFIndex]()
    
    for (i, _) in s.utf16.enumerated() {
        let location: CFIndex = CFStringGetHyphenationLocationBeforeIndex(s as CFString, i, fullRange, 0, locale as CFLocale, nil)
        if hyphenationLocations.last != location {
            hyphenationLocations.append(location)
        }
    }
    
    for l in hyphenationLocations.reversed() {
        guard l > 0 else { continue }
        let strIndex = String.Index(utf16Offset: l, in: s)
        // insert soft hyphen:
        s.insert("\u{00AD}", at: strIndex)
        // or insert a regular hyphen to debug:
        //s.insert("-", at: strIndex)
    }
    
    return s
}
}
