/**
 * Bifrost
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

public protocol RequestConvertible {
    
    associatedtype Response
    
    var request: Request<Response> { get }
}

extension Request: RequestConvertible {
    
    public var request: Request<Response> {
        self
    }
}
