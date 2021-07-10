/**
 * Bifrost
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import XCTest
@testable import Bifrost

class HTTPMethodTests: XCTestCase {
    
    func testRawValue() {
        XCTAssertTrue(HTTPMethod.get.rawValue == "GET")
        XCTAssertTrue(HTTPMethod.head.rawValue == "HEAD")
        XCTAssertTrue(HTTPMethod.post.rawValue == "POST")
        XCTAssertTrue(HTTPMethod.put.rawValue == "PUT")
        XCTAssertTrue(HTTPMethod.delete.rawValue == "DELETE")
        XCTAssertTrue(HTTPMethod.connect.rawValue == "CONNECT")
        XCTAssertTrue(HTTPMethod.options.rawValue == "OPTIONS")
        XCTAssertTrue(HTTPMethod.trace.rawValue == "TRACE")
        XCTAssertTrue(HTTPMethod.patch.rawValue == "PATCH")
    }
}
