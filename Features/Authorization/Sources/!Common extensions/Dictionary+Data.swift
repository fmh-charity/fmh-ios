
import Foundation

extension Dictionary where Key == String, Value == Any? {
    
    func data(_ options: JSONSerialization.WritingOptions = []) throws -> Data {
        return try JSONSerialization.data(withJSONObject: self, options: options)
    }
}
