//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension API {

    /**
    Generate Shopping List

    Generate the shopping list for a user from the meal planner in a given time frame.
    */
    public enum GenerateShoppingList {

        public static let service = APIService<Response>(id: "generateShoppingList", tag: "", method: "POST", path: "/mealplanner/{username}/shopping-list/{start-date}/{end-date}", hasBody: true, securityRequirements: [SecurityRequirement(type: "apiKeyScheme", scopes: [])])

        public final class Request: APIRequest<Response> {

            public struct Options {

                /** The username. */
                public var username: String

                /** The start date in the format yyyy-mm-dd. */
                public var startDate: String

                /** The end date in the format yyyy-mm-dd. */
                public var endDate: String

                /** The private hash for the username. */
                public var hash: String

                public init(username: String, startDate: String, endDate: String, hash: String) {
                    self.username = username
                    self.startDate = startDate
                    self.endDate = endDate
                    self.hash = hash
                }
            }

            public var options: Options

            public init(options: Options) {
                self.options = options
                super.init(service: GenerateShoppingList.service)
            }

            /// convenience initialiser so an Option doesn't have to be created
            public convenience init(username: String, startDate: String, endDate: String, hash: String) {
                let options = Options(username: username, startDate: startDate, endDate: endDate, hash: hash)
                self.init(options: options)
            }

            public override var path: String {
                return super.path.replacingOccurrences(of: "{" + "username" + "}", with: "\(self.options.username)").replacingOccurrences(of: "{" + "start-date" + "}", with: "\(self.options.startDate)").replacingOccurrences(of: "{" + "end-date" + "}", with: "\(self.options.endDate)")
            }

            public override var queryParameters: [String: Any] {
                var params: [String: Any] = [:]
                params["hash"] = options.hash
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