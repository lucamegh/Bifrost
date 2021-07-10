/**
 * Bifrost
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import XCTest
@testable import Bifrost

class ContentTypeTests: XCTestCase {
    
    func testInit() {
        XCTAssertTrue(ContentType("foo/type").rawValue == "foo/type")
    }
    
    func testDefaults() {
        XCTAssertTrue(ContentType.applicationJSON.rawValue == "application/json")
        XCTAssertTrue(ContentType.applicationXML.rawValue == "application/xml")
        XCTAssertTrue(ContentType.textHTML.rawValue == "text/html")
        XCTAssertTrue(ContentType.textPlain.rawValue == "text/plain")
    }
    
    func testExpressibleByStringLiteral() {
        XCTAssertEqual(ContentType.applicationJSON, "application/json")
    }
}
