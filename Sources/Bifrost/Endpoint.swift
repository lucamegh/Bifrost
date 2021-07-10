/**
 * Bifrost
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import Foundation

public struct Endpoint<Response> {
    
    let url: URL
    
    public init(baseURL: URL, path: String = "", queryItems: [URLQueryItem]? = nil) {
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)!
        components.path += path
        components.queryItems = queryItems
        self.url = components.url!
    }
}

public extension Endpoint {
    
    init(_ url: URL) {
        self.url = url
    }
}

extension Endpoint: ExpressibleByStringLiteral {

    public init(stringLiteral value: StaticString) {
        self = Endpoint(URL(string: "\(value)")!)
    }
}

extension Endpoint: Hashable {}
