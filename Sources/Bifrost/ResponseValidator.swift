/**
 * Bifrost
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import Foundation

public struct ResponseValidator {
    
    let validate: (HTTPURLResponse) -> Bool
    
    public init(_ validate: @escaping (HTTPURLResponse) -> Bool) {
        self.validate = validate
    }
}

public extension ResponseValidator {
    
    static let `default` = ResponseValidator.statusCode(in: 200..<300)
    
    static let always = ResponseValidator { _ in true }
    
    static func statusCode(in range: Range<Int>) -> Self {
        ResponseValidator { response in
            range.contains(response.statusCode)
        }
    }
    
    static func statusCode(_ statusCode: Int) -> Self {
        ResponseValidator { response in
            response.statusCode == statusCode
        }
    }
}
