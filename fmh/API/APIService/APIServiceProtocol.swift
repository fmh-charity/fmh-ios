//
//  APIServiceProtocol.swift
//  fmh
//
//  Created: 20.05.2023
//

import Foundation

protocol APIServiceProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
    func data(from url: URL) async throws -> (Data, URLResponse)
}
