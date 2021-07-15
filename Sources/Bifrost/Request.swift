/**
 * Bifrost
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import Foundation

public struct Request<Response> {
        
    public let method: HTTPMethod
    
    public let endpoint: Endpoint<Response>
    
    public var headers: [HTTPHeader]?
    
    public var body: Data?
    
    public let validator: ResponseValidator
    
    public let parser: ResponseParser<Response>
        
    public init(
        method: HTTPMethod = .get,
        endpoint: Endpoint<Response>,
        headers: [HTTPHeader]? = nil,
        body: Data?,
        validator: ResponseValidator = .default,
        parser: ResponseParser<Response>
    ) {
        self.method = method
        self.endpoint = endpoint
        self.headers = headers
        self.body = body
        self.validator = validator
        self.parser = parser
    }
    
    func validateResponse(_ response: HTTPURLResponse) -> Bool {
        validator.validate(response)
    }
    
    func parseResponse(_ data: Data) throws -> Response {
        try parser.parse(data)
    }
}

public extension Request {
    
    func map<NewResponse>(_ transform: @escaping (Response) -> NewResponse) -> Request<NewResponse> {
        Request<NewResponse>(
            method: method,
            endpoint: Endpoint(endpoint.url),
            headers: headers,
            body: body,
            validator: validator,
            parser: parser.map(transform)
        )
    }
}

public extension Request where Response: Decodable {
    
    init(
        method: HTTPMethod = .get,
        endpoint: Endpoint<Response>,
        headers: [HTTPHeader]? = nil,
        body: Data? = nil,
        validator: ResponseValidator = .default,
        decoder: JSONDecoder = .init()
    ) {
        self.init(
            method: method,
            endpoint: endpoint,
            headers: headers,
            body: body,
            validator: validator,
            parser: .decodableResponse(decoder: decoder)
        )
    }
}

public extension Request where Response == Void {
    
    init(
        method: HTTPMethod = .get,
        endpoint: Endpoint<Response>,
        heaeders: [HTTPHeader]? = nil,
        body: Data? = nil,
        validator: ResponseValidator = .default
    ) {
        self.init(
            method: method,
            endpoint: endpoint,
            headers: heaeders,
            body: body,
            validator: validator,
            parser: .void
        )
    }
}
