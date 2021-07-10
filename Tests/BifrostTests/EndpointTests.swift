/**
 * Bifrost
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import XCTest
@testable import Bifrost

enum Foo {}

class EndpointTests: XCTestCase {
    
    func testDefaultInit() {
        let endpoint = Endpoint<Foo>(
            baseURL: URL(string: "https://example.com/")!,
            path: "foo",
            queryItems: [
                URLQueryItem(name: "color", value: "purple"),
                URLQueryItem(name: "count", value: "23")
            ]
        )
        XCTAssertEqual(
            endpoint.url,
            URL(string: "https://example.com/foo?color=purple&count=23")
        )
    }
    
    func testURLInit() {
        let url = URL(string: "https://example.com/foo?color=purple&count=23")!
        XCTAssertEqual(
            Endpoint<Foo>(url).url,
            url
        )
    }
    
    func testExpressibleByStringLiteral() {
        XCTAssertEqual(
            Endpoint<Foo>(
                baseURL: URL(string: "https://example.com/")!,
                path: "foo",
                queryItems: [
                    URLQueryItem(name: "color", value: "purple"),
                    URLQueryItem(name: "count", value: "23")
                ]
            ),
            "https://example.com/foo?color=purple&count=23"
        )
    }
}
