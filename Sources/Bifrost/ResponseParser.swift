/**
 * Bifrost
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import Foundation

public struct ResponseParser<Response> {
    
    let parse: (Data) throws -> Response
    
    public init(_ parse: @escaping (Data) throws -> Response) {
        self.parse = parse
    }
}

public extension ResponseParser {
    
    func map<NewResponse>(_ transform: @escaping (Response) -> NewResponse) -> ResponseParser<NewResponse> {
        ResponseParser<NewResponse> { data in
            try transform(parse(data))
        }
    }
}

public extension ResponseParser where Response: Decodable {
    
    static func decodableResponse(decoder: JSONDecoder = .init()) -> Self {
        ResponseParser { data in
            try decoder.decode(Response.self, from: data)
        }
    }
}

public extension ResponseParser where Response == Void {
    
    static let void = ResponseParser { _ in }
}
