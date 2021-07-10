/**
 * Bifrost
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import Foundation

extension URLRequest {
    
    init<Response>(method: HTTPMethod, endpoint: Endpoint<Response>, headers: [HTTPHeader]?, body: Data?) {
        self.init(url: endpoint.url)
        httpMethod = method.rawValue
        headers?.forEach { addValue($0.value, forHTTPHeaderField: $0.field) }
        httpBody = body
    }
}
