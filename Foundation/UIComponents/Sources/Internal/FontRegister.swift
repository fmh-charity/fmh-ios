
import UIKit
import CoreGraphics
import CoreText

/// Registr custom fonts.
struct FontRegister {
    
    var name: String
    
    init(named name: String) {
        self.name = name
        guard !isRegisteredFontName(name) else {
            return
        }
        do {
            try registerFont(named: name)
        } catch {
            let reason = error.localizedDescription
            fatalError("Failed to register font: \(reason)")
        }
    }
    
    // MARK: - Private
    
    private func registerFont(named name: String) throws {
        guard
            let asset = NSDataAsset(name: "Fonts/\(name)", bundle: .module),
            let provider = CGDataProvider(data: asset.data as NSData),
            let font = CGFont(provider),
            CTFontManagerRegisterGraphicsFont(font, nil)
        else {
            let error = NSError(domain: "UIComponents.FontRegister", code: 0, userInfo: [
                NSLocalizedDescriptionKey: "Register font",
                NSLocalizedFailureReasonErrorKey: "The font has not been registered"
            ])
            throw error
        }
    }
    
    private func isRegisteredFontName(_ name: String) -> Bool {
        let fontNameComponents = name.components(separatedBy: "-")
        guard
            let firstName = fontNameComponents.first,
            let familyName =  UIFont.familyNames.first(where: { $0 == firstName}),
            let _ =  UIFont.fontNames(forFamilyName: familyName).first(where: { $0 == name})
        else {
            return false
        }
        return true
    }
    
    // MARK: - Public
    
    func font(ofSize: CGFloat) -> UIFont? {
        let registeredFontName = Self.init(named: self.name).name
        return UIFont(name: registeredFontName, size: ofSize)
    }
    
    func font(textStyle: UIFont.TextStyle) -> UIFont? {
        let registeredFontName = Self.init(named: self.name).name
        let fontDescriptor = UIFontDescriptor.preferredFontDescriptor(withTextStyle: textStyle)
        guard let font = UIFont(name: registeredFontName, size: fontDescriptor.pointSize) else {
            return nil
        }
        return UIFontMetrics.default.scaledFont(for: font)
    }
}
