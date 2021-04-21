# API

This is an api generated from a OpenAPI 3.0 spec with [SwagGen](https://github.com/yonaskolb/SwagGen)

## Operation

Each operation lives under the `API` namespace and within an optional tag: `API(.tagName).operationId`. If an operation doesn't have an operationId one will be generated from the path and method.

Each operation has a nested `Request` and a `Response`, as well as a static `service` property

#### Service

This is the struct that contains the static information about an operation including it's id, tag, method, pre-modified path, and authorization requirements. It has a generic `ResponseType` type which maps to the `Response` type.
You shouldn't really need to interact with this service type.

#### Request

Each request is a subclass of `APIRequest` and has an `init` with a body param if it has a body, and a `options` struct for other url and path parameters. There is also a convenience init for passing parameters directly.
The `options` and `body` structs are both mutable so they can be modified before actually sending the request.

#### Response

The response is an enum of all the possible responses the request can return. it also contains getters for the `statusCode`, whether it was `successful`, and the actual decoded optional `success` response. If the operation only has one type of failure type there is also an optional `failure` type.

## Model
Models that are sent and returned from the API are mutable classes. Each model is `Equatable` and `Codable`.

`Required` properties are non optional and non-required are optional

All properties can be passed into the initializer, with `required` properties being mandatory.

If a model has `additionalProperties` it will have a subscript to access these by string

## APIClient
The `APIClient` is used to encode, authorize, send, monitor, and decode the requests. There is a `APIClient.default` that uses the default `baseURL` otherwise a custom one can be initialized:

```swift
public init(baseURL: String, sessionManager: SessionManager = .default, defaultHeaders: [String: String] = [:], behaviours: [RequestBehaviour] = [])
```

#### APIClient properties

- `baseURL`: The base url that every request `path` will be appended to
- `behaviours`: A list of [Request Behaviours](#requestbehaviour) to add to every request
- `sessionManager`: An `Alamofire.SessionManager` that can be customized
- `defaultHeaders`: Headers that will be applied to every request
- `decodingQueue`: The `DispatchQueue` to decode responses on

#### Making a request
To make a request first initialize a [Request](#request) and then pass it to `makeRequest`. The `complete` closure will be called with an `APIResponse`

```swift
func makeRequest<T>(_ request: APIRequest<T>, behaviours: [RequestBehaviour] = [], queue: DispatchQueue = DispatchQueue.main, complete: @escaping (APIResponse<T>) -> Void) -> Request? {
```

Example request (that is not neccessarily in this api):

```swift

let getUserRequest = API.User.GetUser.Request(id: 123)
let apiClient = APIClient.default

apiClient.makeRequest(getUserRequest) { apiResponse in
    switch apiResponse {
        case .result(let apiResponseValue):
        	if let user = apiResponseValue.success {
        		print("GetUser returned user \(user)")
        	} else {
        		print("GetUser returned \(apiResponseValue)")
        	}
        case .error(let apiError):
        	print("GetUser failed with \(apiError)")
    }
}
```

Each [Request](#request) also has a `makeRequest` convenience function that uses `API.shared`.

#### APIResponse
The `APIResponse` that gets passed to the completion closure contains the following properties:

- `request`: The original request
- `result`: A `Result` type either containing an `APIClientError` or the [Response](#response) of the request
- `urlRequest`: The `URLRequest` used to send the request
- `urlResponse`: The `HTTPURLResponse` that was returned by the request
- `data`: The `Data` returned by the request.
- `timeline`: The `Alamofire.Timeline` of the request which contains timing information.

#### Encoding and Decoding
Only JSON requests and responses are supported. These are encoded and decoded by `JSONEncoder` and `JSONDecoder` respectively, using Swift's `Codable` apis.
There are some options to control how invalid JSON is handled when decoding and these are available as static properties on `API`:

- `safeOptionalDecoding`: Whether to discard any errors when decoding optional properties. Defaults to `true`.
- `safeArrayDecoding`: Whether to remove invalid elements instead of throwing when decoding arrays. Defaults to `true`.

Dates are encoded and decoded differently according to the swagger date format. They use different `DateFormatter`'s that you can set.
- `date-time`
    - `DateTime.dateEncodingFormatter`: defaults to `yyyy-MM-dd'T'HH:mm:ss.Z`
    - `DateTime.dateDecodingFormatters`: an array of date formatters. The first one to decode successfully will be used
- `date`
    - `DateDay.dateFormatter`: defaults to `yyyy-MM-dd`

#### APIClientError
This is error enum that `APIResponse.result` may contain:

```swift
public enum APIClientError: Error {
    case unexpectedStatusCode(statusCode: Int, data: Data)
    case decodingError(DecodingError)
    case requestEncodingError(String)
    case validationError(String)
    case networkError(Error)
    case unknownError(Error)
}
```

#### RequestBehaviour
Request behaviours are used to modify, authorize, monitor or respond to requests. They can be added to the `APIClient.behaviours` for all requests, or they can passed into `makeRequest` for just that single request.

`RequestBehaviour` is a protocol you can conform to with each function being optional. As the behaviours must work across multiple different request types, they only have access to a typed erased `AnyRequest`.

```swift
public protocol RequestBehaviour {

    /// runs first and allows the requests to be modified. If modifying asynchronously use validate
    func modifyRequest(request: AnyRequest, urlRequest: URLRequest) -> URLRequest

    /// validates and modifies the request. complete must be called with either .success or .fail
    func validate(request: AnyRequest, urlRequest: URLRequest, complete: @escaping (RequestValidationResult) -> Void)

    /// called before request is sent
    func beforeSend(request: AnyRequest)

    /// called when request successfuly returns a 200 range response
    func onSuccess(request: AnyRequest, result: Any)

    /// called when request fails with an error. This will not be called if the request returns a known response even if the a status code is out of the 200 range
    func onFailure(request: AnyRequest, error: APIClientError)

    /// called if the request recieves a network response. This is not called if request fails validation or encoding
    func onResponse(request: AnyRequest, response: AnyResponse)
}
```

### Authorization
Each request has an optional `securityRequirement`. You can create a `RequestBehaviour` that checks this requirement and adds some form of authorization (usually via headers) in `validate` or `modifyRequest`. An alternative way is to set the `APIClient.defaultHeaders` which applies to all requests.

#### Reactive and Promises
To add support for a specific asynchronous library, just add an extension on `APIClient` and add a function that wraps the `makeRequest` function and converts from a closure based syntax to returning the object of choice (stream, future...ect)

## Models


## Requests

- **API.AddToMealPlan**: POST `/mealplanner/{username}/items`
- **API.AddToShoppingList**: POST `/mealplanner/{username}/shopping-list/items`
- **API.AnalyzeARecipeSearchQuery**: GET `/recipes/queries/analyze`
- **API.AnalyzeRecipeInstructions**: POST `/recipes/analyzeinstructions`
- **API.AutocompleteIngredientSearch**: GET `/food/ingredients/autocomplete`
- **API.AutocompleteMenuItemSearch**: GET `/food/menuitems/suggest`
- **API.AutocompleteProductSearch**: GET `/food/products/suggest`
- **API.AutocompleteRecipeSearch**: GET `/recipes/autocomplete`
- **API.ClassifyCuisine**: POST `/recipes/cuisine`
- **API.ClassifyGroceryProduct**: POST `/food/products/classify`
- **API.ClassifyGroceryProductBulk**: POST `/food/products/classifybatch`
- **API.ClearMealPlanDay**: DELETE `/mealplanner/{username}/day/{date}`
- **API.ComputeGlycemicLoad**: POST `/food/ingredients/glycemicload`
- **API.ConnectUser**: POST `/users/connect`
- **API.ConvertAmounts**: GET `/recipes/convert`
- **API.CreateRecipeCard**: POST `/recipes/visualizerecipe`
- **API.DeleteFromMealPlan**: DELETE `/mealplanner/{username}/items/{id}`
- **API.DeleteFromShoppingList**: DELETE `/mealplanner/{username}/shopping-list/items/{id}`
- **API.DetectFoodInText**: POST `/food/detect`
- **API.ExtractRecipeFromWebsite**: GET `/recipes/extract`
- **API.GenerateMealPlan**: GET `/mealplanner/generate`
- **API.GenerateShoppingList**: POST `/mealplanner/{username}/shopping-list/{start-date}/{end-date}`
- **API.GetARandomFoodJoke**: GET `/food/jokes/random`
- **API.GetAnalyzedRecipeInstructions**: GET `/recipes/{id}/analyzedinstructions`
- **API.GetComparableProducts**: GET `/food/products/upc/{upc}/comparable`
- **API.GetConversationSuggests**: GET `/food/converse/suggest`
- **API.GetDishPairingForWine**: GET `/food/wine/dishes`
- **API.GetIngredientInformation**: GET `/food/ingredients/{id}/information`
- **API.GetIngredientSubstitutes**: GET `/food/ingredients/substitutes`
- **API.GetIngredientSubstitutesByID**: GET `/food/ingredients/{id}/substitutes`
- **API.GetMealPlanTemplate**: GET `/mealplanner/{username}/templates/{id}`
- **API.GetMealPlanTemplates**: GET `/mealplanner/{username}/templates`
- **API.GetMealPlanWeek**: GET `/mealplanner/{username}/week/{start-date}`
- **API.GetMenuItemInformation**: GET `/food/menuitems/{id}`
- **API.GetProductInformation**: GET `/food/products/{id}`
- **API.GetRandomFoodTrivia**: GET `/food/trivia/random`
- **API.GetRandomRecipes**: GET `/recipes/random`
- **API.GetRecipeEquipmentByID**: GET `/recipes/{id}/equipmentwidget.json`
- **API.GetRecipeInformation**: GET `/recipes/{id}/information`
- **API.GetRecipeInformationBulk**: GET `/recipes/informationbulk`
- **API.GetRecipeIngredientsByID**: GET `/recipes/{id}/ingredientwidget.json`
- **API.GetRecipeNutritionWidgetByID**: GET `/recipes/{id}/nutritionwidget.json`
- **API.GetRecipePriceBreakdownByID**: GET `/recipes/{id}/pricebreakdownwidget.json`
- **API.GetRecipeTasteByID**: GET `/recipes/{id}/tastewidget.json`
- **API.GetShoppingList**: GET `/mealplanner/{username}/shopping-list`
- **API.GetSimilarRecipes**: GET `/recipes/{id}/similar`
- **API.GetWineDescription**: GET `/food/wine/description`
- **API.GetWinePairing**: GET `/food/wine/pairing`
- **API.GetWineRecommendation**: GET `/food/wine/recommendation`
- **API.GuessNutritionByDishName**: GET `/recipes/guessnutrition`
- **API.ImageAnalysisByURL**: GET `/food/images/analyze`
- **API.ImageClassificationByURL**: GET `/food/images/classify`
- **API.IngredientSearch**: GET `/food/ingredients/search`
- **API.MapIngredientsToGroceryProducts**: POST `/food/ingredients/map`
- **API.ParseIngredients**: POST `/recipes/parseingredients`
- **API.QuickAnswer**: GET `/recipes/quickanswer`
- **API.SearchAllFood**: GET `/food/search`
- **API.SearchCustomFoods**: GET `/food/customfoods/search`
- **API.SearchFoodVideos**: GET `/food/videos/search`
- **API.SearchGroceryProducts**: GET `/food/products/search`
- **API.SearchGroceryProductsByUPC**: GET `/food/products/upc/{upc}`
- **API.SearchMenuItems**: GET `/food/menuitems/search`
- **API.SearchRecipes**: GET `/recipes/complexsearch`
- **API.SearchRecipesByIngredients**: GET `/recipes/findbyingredients`
- **API.SearchRecipesByNutrients**: GET `/recipes/findbynutrients`
- **API.SearchSiteContent**: GET `/food/site/search`
- **API.SummarizeRecipe**: GET `/recipes/{id}/summary`
- **API.TalkToChatbot**: GET `/food/converse`
- **API.VisualizeEquipment**: POST `/recipes/visualizeequipment`
- **API.VisualizeIngredients**: POST `/recipes/visualizeingredients`
- **API.VisualizeMenuItemNutritionByID**: GET `/food/menuitems/{id}/nutritionwidget`
- **API.VisualizePriceBreakdown**: POST `/recipes/visualizepriceestimator`
- **API.VisualizeProductNutritionByID**: GET `/food/products/{id}/nutritionwidget`
- **API.VisualizeRecipeEquipmentByID**: GET `/recipes/{id}/equipmentwidget`
- **API.VisualizeRecipeIngredientsByID**: GET `/recipes/{id}/ingredientwidget`
- **API.VisualizeRecipeNutrition**: POST `/recipes/visualizenutrition`
- **API.VisualizeRecipeNutritionByID**: GET `/recipes/{id}/nutritionwidget`
- **API.VisualizeRecipePriceBreakdownByID**: GET `/recipes/{id}/pricebreakdownwidget`
- **API.VisualizeRecipeTaste**: POST `/recipes/visualizetaste`
- **API.VisualizeRecipeTasteByID**: GET `/recipes/{id}/tastewidget`
