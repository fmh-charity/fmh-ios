
import Foundation

extension Array {
    
    mutating func modify(_ body: (inout Element) throws -> Void) rethrows {
        var index = self.startIndex
        while index != self.endIndex {
            try body(&self[index])
            self.formIndex(after: &index)
        }
    }
}
