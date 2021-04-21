//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension API {

    /**
    Get Random Recipes

    Find random (popular) recipes. If you need to filter recipes by diet, nutrition etc. you might want to consider using the complex recipe search endpoint and set the sort request parameter to random.
    */
    public enum GetRandomRecipes {

        public static let service = APIService<Response>(id: "getRandomRecipes", tag: "", method: "GET", path: "/recipes/random", hasBody: false, securityRequirements: [SecurityRequirement(type: "apiKeyScheme", scopes: [])])

        public final class Request: APIRequest<Response> {

            public struct Options {

                /** Whether the recipes should have an open license that allows display with proper attribution. */
                public var limitLicense: Bool?

                /** The tags (can be diets, meal types, cuisines, or intolerances) that the recipe must have. */
                public var tags: String?

                /** The number of random recipes to be returned (between 1 and 100). */
                public var number: Double?

                public init(limitLicense: Bool? = nil, tags: String? = nil, number: Double? = nil) {
                    self.limitLicense = limitLicense
                    self.tags = tags
                    self.number = number
                }
            }

            public var options: Options

            public init(options: Options) {
                self.options = options
                super.init(service: GetRandomRecipes.service)
            }

            /// convenience initialiser so an Option doesn't have to be created
            public convenience init(limitLicense: Bool? = nil, tags: String? = nil, number: Double? = nil) {
                let options = Options(limitLicense: limitLicense, tags: tags, number: number)
                self.init(options: options)
            }

            public override var queryParameters: [String: Any] {
                var params: [String: Any] = [:]
                if let limitLicense = options.limitLicense {
                  params["limitLicense"] = limitLicense
                }
                if let tags = options.tags {
                  params["tags"] = tags
                }
                if let number = options.number {
                  params["number"] = number
                }
                return params
            }
        }

        public enum Response: APIResponseValue, CustomStringConvertible, CustomDebugStringConvertible {
            public typealias SuccessType = [String: Any]

            /** Success */
            case status200([String: Any])

            /** Unauthorized */
            case status401

            /** Forbidden */
            case status403

            /** Not Found */
            case status404

            public var success: [String: Any]? {
                switch self {
                case .status200(let response): return response
                default: return nil
                }
            }

            public var response: Any {
                switch self {
                case .status200(let response): return response
                default: return ()
                }
            }

            public var statusCode: Int {
                switch self {
                case .status200: return 200
                case .status401: return 401
                case .status403: return 403
                case .status404: return 404
                }
            }

            public var successful: Bool {
                switch self {
                case .status200: return true
                case .status401: return false
                case .status403: return false
                case .status404: return false
                }
            }

            public init(statusCode: Int, data: Data, decoder: ResponseDecoder) throws {
                switch statusCode {
                case 200: self = try .status200(decoder.decodeAny([String: Any].self, from: data))
                case 401: self = .status401
                case 403: self = .status403
                case 404: self = .status404
                default: throw APIClientError.unexpectedStatusCode(statusCode: statusCode, data: data)
                }
            }

            public var description: String {
                return "\(statusCode) \(successful ? "success" : "failure")"
            }

            public var debugDescription: String {
                var string = description
                let responseString = "\(response)"
                if responseString != "()" {
                    string += "\n\(responseString)"
                }
                return string
            }
        }
    }
}