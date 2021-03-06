//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension API {

    /**
    Get Wine Pairing

    Find a wine that goes well with a food. Food can be a dish name ("steak"), an ingredient name ("salmon"), or a cuisine ("italian").
    */
    public enum GetWinePairing {

        public static let service = APIService<Response>(id: "getWinePairing", tag: "", method: "GET", path: "/food/wine/pairing", hasBody: false, securityRequirements: [SecurityRequirement(type: "apiKeyScheme", scopes: [])])

        public final class Request: APIRequest<Response> {

            public struct Options {

                /** The food to get a pairing for. This can be a dish ("steak"), an ingredient ("salmon"), or a cuisine ("italian"). */
                public var food: String

                /** The maximum price for the specific wine recommendation in USD. */
                public var maxPrice: Double?

                public init(food: String, maxPrice: Double? = nil) {
                    self.food = food
                    self.maxPrice = maxPrice
                }
            }

            public var options: Options

            public init(options: Options) {
                self.options = options
                super.init(service: GetWinePairing.service)
            }

            /// convenience initialiser so an Option doesn't have to be created
            public convenience init(food: String, maxPrice: Double? = nil) {
                let options = Options(food: food, maxPrice: maxPrice)
                self.init(options: options)
            }

            public override var queryParameters: [String: Any] {
                var params: [String: Any] = [:]
                params["food"] = options.food
                if let maxPrice = options.maxPrice {
                  params["maxPrice"] = maxPrice
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
