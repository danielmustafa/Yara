//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension API {

    /**
    Visualize Price Breakdown

    Visualize the price breakdown of a recipe. You can play around with that endpoint!
    */
    public enum VisualizePriceBreakdown {

        public static let service = APIService<Response>(id: "visualizePriceBreakdown", tag: "", method: "POST", path: "/recipes/visualizePriceEstimator", hasBody: true, securityRequirements: [SecurityRequirement(type: "apiKeyScheme", scopes: [])])

        public final class Request: APIRequest<Response> {

            public struct Options {

                /** The ingredient list of the recipe, one ingredient per line. */
                public var ingredientList: String

                /** The number of servings. */
                public var servings: Double

                /** Whether the default CSS should be added to the response. */
                public var defaultCss: Bool?

                /** The mode in which the widget should be delivered. 1 = separate views (compact), 2 = all in one view (full). */
                public var mode: Double?

                /** Whether to show a backlink to spoonacular. If set false, this call counts against your quota. */
                public var showBacklink: Bool?

                public init(ingredientList: String, servings: Double, defaultCss: Bool? = nil, mode: Double? = nil, showBacklink: Bool? = nil) {
                    self.ingredientList = ingredientList
                    self.servings = servings
                    self.defaultCss = defaultCss
                    self.mode = mode
                    self.showBacklink = showBacklink
                }
            }

            public var options: Options

            public init(options: Options) {
                self.options = options
                super.init(service: VisualizePriceBreakdown.service)
            }

            /// convenience initialiser so an Option doesn't have to be created
            public convenience init(ingredientList: String, servings: Double, defaultCss: Bool? = nil, mode: Double? = nil, showBacklink: Bool? = nil) {
                let options = Options(ingredientList: ingredientList, servings: servings, defaultCss: defaultCss, mode: mode, showBacklink: showBacklink)
                self.init(options: options)
            }

            public override var formParameters: [String: Any] {
                var params: [String: Any] = [:]
                params["ingredientList"] = options.ingredientList
                params["servings"] = options.servings
                if let defaultCss = options.defaultCss {
                  params["defaultCss"] = defaultCss
                }
                if let mode = options.mode {
                  params["mode"] = mode
                }
                if let showBacklink = options.showBacklink {
                  params["showBacklink"] = showBacklink
                }
                return params
            }
        }

        public enum Response: APIResponseValue, CustomStringConvertible, CustomDebugStringConvertible {
            public typealias SuccessType = String

            /** Success */
            case status200(String)

            /** Unauthorized */
            case status401

            /** Forbidden */
            case status403

            /** Not Found */
            case status404

            public var success: String? {
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
                case 200: self = try .status200(decoder.decode(String.self, from: data))
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
