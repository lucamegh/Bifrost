/**
 * Bifrost
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import Foundation

public struct ContentType {
    
    let rawValue: String
    
    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
}

public extension ContentType {
    
    static let applicationJSON: ContentType = "application/json"
    
    static let applicationXML: ContentType = "application/xml"
    
    static let textHTML: ContentType = "text/html"
    
    static let textPlain: ContentType = "text/plain"
    
    static var multipartFormData: ContentType {
        multipartFormData(boundary: UUID().uuidString)
    }
    
    static func multipartFormData(boundary: String) -> ContentType {
        ContentType("multipart/form-data; boundary=\(boundary)")
    }
}

extension ContentType: ExpressibleByStringLiteral {
    
    public init(stringLiteral value: String) {
        self.rawValue = "\(value)"
    }
}

extension ContentType: Hashable {}
