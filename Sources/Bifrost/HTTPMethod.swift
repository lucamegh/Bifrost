/**
 * Bifrost
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

public struct HTTPMethod {
        
    let rawValue: String
        
    private init(_ rawValue: String) {
        self.rawValue = rawValue
    }
}

public extension HTTPMethod {
    
    static let get = HTTPMethod("GET")
    
    static let head = HTTPMethod("HEAD")
    
    static let post = HTTPMethod("POST")
    
    static let put = HTTPMethod("PUT")
    
    static let delete = HTTPMethod("DELETE")
    
    static let connect = HTTPMethod("CONNECT")
    
    static let options = HTTPMethod("OPTIONS")
    
    static let trace = HTTPMethod("TRACE")
    
    static let patch = HTTPMethod("PATCH")
}

extension HTTPMethod: Hashable {}
