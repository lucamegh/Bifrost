/**
 * Bifrost
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import XCTest
@testable import Bifrost

class ResponseValidatorTests: XCTestCase {
    
    func testDefault() {
        let validator = ResponseValidator.default
        for response in HTTPURLResponse.stubs {
            switch response.statusCode {
            case 200..<300:
                XCTAssertTrue(validator.validate(response))
            default:
                XCTAssertFalse(validator.validate(response))
            }
        }
    }
    
    func testAlways() {
        let validator = ResponseValidator.always
        for response in HTTPURLResponse.stubs {
            XCTAssertTrue(validator.validate(response))
        }
    }
    
    func testStatusCodeInRange() {
        let range = 300..<400
        let validator = ResponseValidator.statusCode(in: range)
        for response in HTTPURLResponse.stubs {
            switch response.statusCode {
            case range:
                XCTAssertTrue(validator.validate(response))
            default:
                XCTAssertFalse(validator.validate(response))
            }
        }
    }
    
    func testStatusCode() {
        let statusCode = 123
        let validator = ResponseValidator.statusCode(statusCode)
        for response in HTTPURLResponse.stubs {
            switch response.statusCode {
            case statusCode:
                XCTAssertTrue(validator.validate(response))
            default:
                XCTAssertFalse(validator.validate(response))
            }
        }
    }
}

private extension HTTPURLResponse {
    
    static var stubs: [HTTPURLResponse] {
        (100..<600).map { statusCode in
            HTTPURLResponse(
                url: URL(string: "/dev/null")!,
                statusCode: statusCode,
                httpVersion: nil,
                headerFields: nil
            )!
        }
    }
}
