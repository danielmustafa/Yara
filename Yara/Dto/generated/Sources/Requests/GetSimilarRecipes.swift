//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension API {

    /**
    Get Similar Recipes

    Find recipes which are similar to the given one.
    */
    public enum GetSimilarRecipes {

        public static let service = APIService<Response>(id: "getSimilarRecipes", tag: "", method: "GET", path: "/recipes/{id}/similar", hasBody: false, securityRequirements: [SecurityRequirement(type: "apiKeyScheme", scopes: [])])

        public final class Request: APIRequest<Response> {

            public struct Options {

                /** The id of the source recipe for which similar recipes should be found. */
                public var id: Double

                /** The number of random recipes to be returned (between 1 and 100). */
                public var number: Double?

                /** Whether the recipes should have an open license that allows display with proper attribution. */
                public var limitLicense: Bool?

                public init(id: Double, number: Double? = nil, limitLicense: Bool? = nil) {
                    self.id = id
                    self.number = number
                    self.limitLicense = limitLicense
                }
            }

            public var options: Options

            public init(options: Options) {
                self.options = options
                super.init(service: GetSimilarRecipes.service)
            }

            /// convenience initialiser so an Option doesn't have to be created
            public convenience init(id: Double, number: Double? = nil, limitLicense: Bool? = nil) {
                let options = Options(id: id, number: number, limitLicense: limitLicense)
                self.init(options: options)
            }

            public override var path: String {
                return super.path.replacingOccurrences(of: "{" + "id" + "}", with: "\(self.options.id)")
            }

            public override var queryParameters: [String: Any] {
                var params: [String: Any] = [:]
                if let number = options.number {
                  params["number"] = number
                }
                if let limitLicense = options.limitLicense {
                  params["limitLicense"] = limitLicense
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