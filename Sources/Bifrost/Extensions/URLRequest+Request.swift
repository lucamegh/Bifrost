/**
 * Bifrost
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import Foundation

extension URLRequest {
    
    init<Response>(_ request: Request<Response>) {
        self.init(url: request.endpoint.url)
        httpMethod = request.method.rawValue
        request.headers?.forEach { addValue($0.value, forHTTPHeaderField: $0.field) }
        httpBody = request.body
    }
}
