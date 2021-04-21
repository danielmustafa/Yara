//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension API {

    /**
    Search Menu Items

    Search over 115,000 menu items from over 800 fast food and chain restaurants. For example, McDonald's Big Mac or Starbucks Mocha.
    */
    public enum SearchMenuItems {

        public static let service = APIService<Response>(id: "searchMenuItems", tag: "", method: "GET", path: "/food/menuItems/search", hasBody: false, securityRequirements: [SecurityRequirement(type: "apiKeyScheme", scopes: [])])

        public final class Request: APIRequest<Response> {

            public struct Options {

                /** The search query. */
                public var query: String

                /** The minimum amount of calories the menu item must have. */
                public var minCalories: Double?

                /** The maximum amount of calories the menu item can have. */
                public var maxCalories: Double?

                /** The minimum amount of carbohydrates in grams the menu item must have. */
                public var minCarbs: Double?

                /** The maximum amount of carbohydrates in grams the menu item can have. */
                public var maxCarbs: Double?

                /** The minimum amount of protein in grams the menu item must have. */
                public var minProtein: Double?

                /** The maximum amount of protein in grams the menu item can have. */
                public var maxProtein: Double?

                /** The minimum amount of fat in grams the menu item must have. */
                public var minFat: Double?

                /** The maximum amount of fat in grams the menu item can have. */
                public var maxFat: Double?

                /** The offset number for paging (between 0 and 990). */
                public var offset: Double?

                /** The number of expected results (between 1 and 10). */
                public var number: Double?

                public init(query: String, minCalories: Double? = nil, maxCalories: Double? = nil, minCarbs: Double? = nil, maxCarbs: Double? = nil, minProtein: Double? = nil, maxProtein: Double? = nil, minFat: Double? = nil, maxFat: Double? = nil, offset: Double? = nil, number: Double? = nil) {
                    self.query = query
                    self.minCalories = minCalories
                    self.maxCalories = maxCalories
                    self.minCarbs = minCarbs
                    self.maxCarbs = maxCarbs
                    self.minProtein = minProtein
                    self.maxProtein = maxProtein
                    self.minFat = minFat
                    self.maxFat = maxFat
                    self.offset = offset
                    self.number = number
                }
            }

            public var options: Options

            public init(options: Options) {
                self.options = options
                super.init(service: SearchMenuItems.service)
            }

            /// convenience initialiser so an Option doesn't have to be created
            public convenience init(query: String, minCalories: Double? = nil, maxCalories: Double? = nil, minCarbs: Double? = nil, maxCarbs: Double? = nil, minProtein: Double? = nil, maxProtein: Double? = nil, minFat: Double? = nil, maxFat: Double? = nil, offset: Double? = nil, number: Double? = nil) {
                let options = Options(query: query, minCalories: minCalories, maxCalories: maxCalories, minCarbs: minCarbs, maxCarbs: maxCarbs, minProtein: minProtein, maxProtein: maxProtein, minFat: minFat, maxFat: maxFat, offset: offset, number: number)
                self.init(options: options)
            }

            public override var queryParameters: [String: Any] {
                var params: [String: Any] = [:]
                params["query"] = options.query
                if let minCalories = options.minCalories {
                  params["minCalories"] = minCalories
                }
                if let maxCalories = options.maxCalories {
                  params["maxCalories"] = maxCalories
                }
                if let minCarbs = options.minCarbs {
                  params["minCarbs"] = minCarbs
                }
                if let maxCarbs = options.maxCarbs {
                  params["maxCarbs"] = maxCarbs
                }
                if let minProtein = options.minProtein {
                  params["minProtein"] = minProtein
                }
                if let maxProtein = options.maxProtein {
                  params["maxProtein"] = maxProtein
                }
                if let minFat = options.minFat {
                  params["minFat"] = minFat
                }
                if let maxFat = options.maxFat {
                  params["maxFat"] = maxFat
                }
                if let offset = options.offset {
                  params["offset"] = offset
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