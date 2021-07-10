/**
 * Bifrost
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import Foundation

public struct Request<Response> {
        
    let urlRequest: URLRequest
    
    private let validator: ResponseValidator
    
    private let parser: ResponseParser<Response>
        
    private init(urlRequest: URLRequest, validator: ResponseValidator = .default, parser: ResponseParser<Response>) {
        self.urlRequest = urlRequest
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
            urlRequest: urlRequest,
            validator: validator,
            parser: parser.map(transform)
        )
    }
}

public extension Request {
    
    init(
        method: HTTPMethod = .get,
        endpoint: Endpoint<Response>,
        headers: [HTTPHeader]? = nil,
        body: Data? = nil,
        validator: ResponseValidator = .default,
        parser: ResponseParser<Response>
    ) {
        self.init(
            urlRequest: URLRequest(
                method: method,
                endpoint: endpoint,
                headers: headers,
                body: body
            ),
            validator: validator,
            parser: parser
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
        self = Request(
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
        self = Request(
            method: method,
            endpoint: endpoint,
            headers: heaeders,
            body: body,
            validator: validator,
            parser: .void
        )
    }
}
