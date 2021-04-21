//
// Generated by SwagGen
// https://github.com/yonaskolb/SwagGen
//

import Foundation

extension API {

    /**
    Ingredient Search

    Search for simple whole foods (e.g. fruits, vegetables, nuts, grains, meat, fish, dairy etc.).
    */
    public enum IngredientSearch {

        public static let service = APIService<Response>(id: "ingredientSearch", tag: "", method: "GET", path: "/food/ingredients/search", hasBody: false, securityRequirements: [SecurityRequirement(type: "apiKeyScheme", scopes: [])])

        public final class Request: APIRequest<Response> {

            public struct Options {

                /** The partial or full ingredient name. */
                public var query: String

                /** Whether to add children of found foods. */
                public var addChildren: Bool?

                /** The minimum percentage of protein the food must have (between 0 and 100). */
                public var minProteinPercent: Double?

                /** The maximum percentage of protein the food can have (between 0 and 100). */
                public var maxProteinPercent: Double?

                /** The minimum percentage of fat the food must have (between 0 and 100). */
                public var minFatPercent: Double?

                /** The maximum percentage of fat the food can have (between 0 and 100). */
                public var maxFatPercent: Double?

                /** The minimum percentage of carbs the food must have (between 0 and 100). */
                public var minCarbsPercent: Double?

                /** The maximum percentage of carbs the food can have (between 0 and 100). */
                public var maxCarbsPercent: Double?

                /** Whether to return more meta information about the ingredients. */
                public var metaInformation: Bool?

                /** A comma-separated list of intolerances. All recipes returned must not contain ingredients that are not suitable for people with the intolerances entered. See a full list of supported intolerances. */
                public var intolerances: String?

                /** The strategy to sort recipes by. See a full list of supported sorting options. */
                public var sort: String?

                /** The direction in which to sort. Must be either 'asc' (ascending) or 'desc' (descending). */
                public var sortDirection: String?

                /** The number of results to skip (between 0 and 990). */
                public var offset: Double?

                /** The number of expected results (between 1 and 100). */
                public var number: Double?

                public init(query: String, addChildren: Bool? = nil, minProteinPercent: Double? = nil, maxProteinPercent: Double? = nil, minFatPercent: Double? = nil, maxFatPercent: Double? = nil, minCarbsPercent: Double? = nil, maxCarbsPercent: Double? = nil, metaInformation: Bool? = nil, intolerances: String? = nil, sort: String? = nil, sortDirection: String? = nil, offset: Double? = nil, number: Double? = nil) {
                    self.query = query
                    self.addChildren = addChildren
                    self.minProteinPercent = minProteinPercent
                    self.maxProteinPercent = maxProteinPercent
                    self.minFatPercent = minFatPercent
                    self.maxFatPercent = maxFatPercent
                    self.minCarbsPercent = minCarbsPercent
                    self.maxCarbsPercent = maxCarbsPercent
                    self.metaInformation = metaInformation
                    self.intolerances = intolerances
                    self.sort = sort
                    self.sortDirection = sortDirection
                    self.offset = offset
                    self.number = number
                }
            }

            public var options: Options

            public init(options: Options) {
                self.options = options
                super.init(service: IngredientSearch.service)
            }

            /// convenience initialiser so an Option doesn't have to be created
            public convenience init(query: String, addChildren: Bool? = nil, minProteinPercent: Double? = nil, maxProteinPercent: Double? = nil, minFatPercent: Double? = nil, maxFatPercent: Double? = nil, minCarbsPercent: Double? = nil, maxCarbsPercent: Double? = nil, metaInformation: Bool? = nil, intolerances: String? = nil, sort: String? = nil, sortDirection: String? = nil, offset: Double? = nil, number: Double? = nil) {
                let options = Options(query: query, addChildren: addChildren, minProteinPercent: minProteinPercent, maxProteinPercent: maxProteinPercent, minFatPercent: minFatPercent, maxFatPercent: maxFatPercent, minCarbsPercent: minCarbsPercent, maxCarbsPercent: maxCarbsPercent, metaInformation: metaInformation, intolerances: intolerances, sort: sort, sortDirection: sortDirection, offset: offset, number: number)
                self.init(options: options)
            }

            public override var queryParameters: [String: Any] {
                var params: [String: Any] = [:]
                params["query"] = options.query
                if let addChildren = options.addChildren {
                  params["addChildren"] = addChildren
                }
                if let minProteinPercent = options.minProteinPercent {
                  params["minProteinPercent"] = minProteinPercent
                }
                if let maxProteinPercent = options.maxProteinPercent {
                  params["maxProteinPercent"] = maxProteinPercent
                }
                if let minFatPercent = options.minFatPercent {
                  params["minFatPercent"] = minFatPercent
                }
                if let maxFatPercent = options.maxFatPercent {
                  params["maxFatPercent"] = maxFatPercent
                }
                if let minCarbsPercent = options.minCarbsPercent {
                  params["minCarbsPercent"] = minCarbsPercent
                }
                if let maxCarbsPercent = options.maxCarbsPercent {
                  params["maxCarbsPercent"] = maxCarbsPercent
                }
                if let metaInformation = options.metaInformation {
                  params["metaInformation"] = metaInformation
                }
                if let intolerances = options.intolerances {
                  params["intolerances"] = intolerances
                }
                if let sort = options.sort {
                  params["sort"] = sort
                }
                if let sortDirection = options.sortDirection {
                  params["sortDirection"] = sortDirection
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