/**
 * Bifrost
 * Copyright (c) Luca Meghnagi 2021
 * MIT license, see LICENSE file for details
 */

import Combine
import Foundation

public extension URLSession {
    
    func response<Response>(_ request: Request<Response>) -> AnyPublisher<Response, BifrostError> {
        self.dataTaskPublisher(for: request.urlRequest)
            .mapError { .urlError(code: $0.code) }
            .map { data, response -> Result<Response, BifrostError> in
                guard
                    let httpResponse = response as? HTTPURLResponse,
                    request.validateResponse(httpResponse)
                else {
                    return .failure(.invalidResponse(response))
                }
                
                do {
                    let response = try request.parseResponse(data)
                    return .success(response)
                } catch {
                    return .failure(.parsing(response: data, underlyingError: error))
                }
            }
            .flatMap(\.publisher)
            .eraseToAnyPublisher()
    }
    
    func response<Convertible: RequestConvertible>(_ convertible: Convertible) -> AnyPublisher<Convertible.Response, BifrostError> {
        response(convertible.request)
    }
}

public extension URLSession {
    
    @discardableResult
    func response<Response>(
        _ request: Request<Response>,
        resultQueue: DispatchQueue = .main,
        completionHandler: @escaping (Result<Response, BifrostError>) -> Void
    ) -> URLSessionDataTask {
        defer { task.resume() }
        func complete(with result: Result<Response, BifrostError>) {
            resultQueue.async {
                completionHandler(result)
            }
        }
        let task = dataTask(with: request.urlRequest) { data, response, error in
            if let error = error as? URLError {
                complete(with: .failure(.urlError(code: error.code)))
            } else if let error = error {
                complete(with: .failure(.uncategorized(error)))
            } else if let response = response as? HTTPURLResponse, let data = data {
                guard request.validateResponse(response) else {
                    return complete(with: .failure(.invalidResponse(response)))
                }
                do {
                    let response = try request.parseResponse(data)
                    complete(with: .success(response))
                } catch {
                    complete(with: .failure(.parsing(response: data, underlyingError: error)))
                }
            }
        }
        return task
    }
    
    @discardableResult
    func response<Convertible: RequestConvertible>(
        _ convertible: Convertible,
        resultQueue: DispatchQueue = .main,
        completionHandler: @escaping (Result<Convertible.Response, BifrostError>) -> Void
    ) -> URLSessionDataTask {
        response(
            convertible.request,
            resultQueue: resultQueue,
            completionHandler: completionHandler
        )
    }
}
