//
//  Helpers.swift
//  fmh
//
//  Created: 04.12.2022
//

import Foundation

// MARK: - URLRequest make/configure




extension URL {
    
    init?() {
        let url = Helper.Core.Plist.getValueDictionary(forResource: "", forKey: "urlTest") as? String
        guard let url = url else { return nil }
        self.init(string: url)
    }
    
}



// MARK: - Helpers

extension URLComponents {
    
}

extension Data {
    
    func jsonObject() -> Any? {
        return (try? JSONSerialization.jsonObject(with: self, options: []))
    }
    
    func decode<T: Decodable>(_ decoder: JSONDecoder = JSONDecoder()) throws -> T {
        return try decoder.decode(T.self, from: self)
    }
    
}

extension Dictionary where Key == String, Value == Any? {
    
    func data(_ options: JSONSerialization.WritingOptions = []) throws -> Data {
        return try JSONSerialization.data(withJSONObject: self, options: options)
    }

}

extension Dictionary where Key == String, Value == String? {

    func queryItems()  -> [URLQueryItem]? {
        guard !self.isEmpty else { return nil }
        return self.map { URLQueryItem(name: $0.key, value: $0.value) }
    }
    
}

extension Encodable {
    
    func data(_ encoder: JSONEncoder = JSONEncoder()) throws -> Data {
        return try encoder.encode(self)
    }
    
}
