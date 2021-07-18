# Bifrost 🌈

Lightweight networking library.

## Installation

Bifrost is distributed using [Swift Package Manager](https://swift.org/package-manager). To install it into a project, simply add it as a dependency within your Package.swift manifest:
```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/lucamegh/Bifrost", from: "1.0.0")
    ],
    ...
)
```

## Usage

```swift
struct Recipe: Decodable { ... }

let request = Request<Recipe>(endpoint: "https://api.cookbook.com/recipe/42")

URLSession.shared.response(request) // AnyPublisher<Recipe, BifrostError>
```

### Response Parsing

When creating requests, you always have to provide a `ResponseParser`, a type that encapsulates the `Data` parsing logic. Use the response parser to convert the response data into your model object.

```swift
struct ResponseParser<Response> {
    
    let parse: (Data) throws -> Response
}
```

If your response model conforms to `Decodable`, Bifrost will default to a `Response.decodableResponse(decoder:)` parser when instantiating requests.

### Response Validation

Customize HTTP response validation using `ResponseValidator`. 

```swift
Request(
    ...,
    validator: ResponseValidator { (response: HTTPURLResponse) -> Bool in
        // custom validation
    }
)
```

Bifrost comes with different default response validators that cover the most common use cases:

```swift
ResponseValidator.default // accepts responses with a status code between 200 and 299

ResponseValidator.statusCode(_:) // accepts responses with the provided status code

ResponseValidator.statusCode(in:) // accepts responses with a status code in the provided range

ResponseValidator.always // accepts any response

ResponseValidator.never // accepts no response
```

### Request Mapping

Use the `map(_:)` operator to transform your requests:

```swift
public struct Item: Decodable { ... }

private struct UglyResponse: Decodable {

    let items: [Item]
}

let uglyResponse = Response<UglyResponse>(...)
let itemsResponse = uglyResponse.map(\.items) // Response<[Item]>
URLSession.shared.response(itemsResponse) { result in
    // Result<[Item], BifrostError>
}
```

### Tips

It is very helpful to group all the requests of the same Rest API under a common namespace:

```swift
enum SWAPI {

    static func movie(id: Movie.ID) -> Request<Movie> {
        .swapi(path: "movies/\(id)")
    }

    ...
}

URLSession.shared.response(SWAPI.movie(id: 2)) { result in
    // The Empire Strikes Back!
}
```

Within the same file:

```swift
extension Request where Response: Decodable {

    fileprivate static func swapi(path: String) -> Self {
        Request(
            method: .get,
            endpoint: endpoint(path),
            body: nil,
            validator: .default,
            parser: parser
        )
    }

    private static func endpoint(_ path: String) -> Endpoint<Response> {
        Endpoint(
            baseURL: URL(string: "https://www.swapi.tech/api/")!,
            path: path
        )
    }

    private static var parser: ResponseParser<Response> {
        ResponseParser { data in            
            let response = try decoder.decode(SwapiResponse<Response>.self, from: data)
            return try response.get()
        }
    }

    private static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}
```

### Credtis

This library was inspired by objc.io's [Swift Talk #01](https://talk.objc.io/episodes/S01E1-tiny-networking-library).
