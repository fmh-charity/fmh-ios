
import Foundation

private extension String {

    var isEmailValidate: Bool {
        let pattern = #"^\S+@\S+\.\S+$"#
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: self)
    }
    
    var isPasswordValidate: Bool {
        let pattern = #"^\S+@\S+\.\S+$"#
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: self)
    }
}
