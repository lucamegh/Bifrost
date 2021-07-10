/**
 * Bifrost
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import Foundation

public enum NetworkingError: Error {
        
    case invalidResponse(URLResponse)
    
    case parsing(response: Data, underlyingError: Error)
    
    case urlError(code: URLError.Code)
    
    case uncategorized(Error)
}
