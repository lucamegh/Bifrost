/**
 * Bifrost
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

public struct HTTPHeader {
        
    let field: String
    
    let value: String
        
    public init(_ field: String, _ value: String) {
        self.field = field
        self.value = value
    }
}

public extension HTTPHeader {
    
    static func accept(_ contentType: ContentType) -> HTTPHeader {
        HTTPHeader("Accept", contentType.rawValue)
    }
    
    static func contentType(_ contentType: ContentType) -> HTTPHeader {
        HTTPHeader("Content-Type", contentType.rawValue)
    }
    
    static func userAgent(_ value: String) -> HTTPHeader {
        HTTPHeader("User-Agent", value)
    }
    
    static func authorization(_ value: String) -> HTTPHeader {
        HTTPHeader("Authorization", value)
    }
    
    static func authorization(bearerToken: String) -> HTTPHeader {
        authorization("Bearer \(bearerToken)")
    }
    
    static func authorization(oauthToken: String) -> HTTPHeader {
        authorization("OAuth \(oauthToken)")
    }
    
    static func authorization(basic: String) -> HTTPHeader {
        authorization("Basic \(basic)")
    }
}
