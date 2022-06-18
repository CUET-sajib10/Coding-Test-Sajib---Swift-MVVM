

import Foundation
import Alamofire

struct RequestManager {
    
    enum RequestType: String, CaseIterable {
        case get    = "GET"
        case post   = "POST"
    }
    
    enum ErrorType: Error {
        case noInternet
        case networkProblem
        case errorDescription(Error)
    }
    
    typealias successResponse = ((Data) -> Void)
    typealias errorResponse = ((ErrorType) -> Void)
    
    static func request(using url: String,
                 params: [String : AnyObject]?,
                 type: RequestType,
                 header: HTTPHeaders? = nil,
                 success: @escaping successResponse,
                 failure: @escaping errorResponse) {
                
                AF.request(url, method: HTTPMethod(rawValue: type.rawValue), parameters: params, encoding: type == .post ? JSONEncoding.default : URLEncoding.queryString, headers: header).responseData { (responseData) -> Void in
                    switch responseData.response?.statusCode {
                    case 200, 201:
                        switch responseData.result {
                        case .success(let responseData):
                            success(responseData)
                        case .failure(let error):
                            failure(.errorDescription(error))
                        }
                        break
                    case 400, 401, 404, 500:
                        failure(.networkProblem)
                    default:
                        failure(.networkProblem)
                    }
                }
            
        }
    }


enum HttpURL: String {
    
    case SEARCH_ARTICLE          = "svc/search/v2/articlesearch.json?"
    case MOST_EMAILED           = "svc/mostpopular/v2/emailed/1.json?api-key="
    case MOST_SHARED            = "svc/mostpopular/v2/shared/1.json?api-key="
    case MOST_VIEWED            = "svc/mostpopular/v2/viewed/1.json?api-key="
    
    var url: String {
        
        var configuration = Configuration()
        
        switch self {
            
        case .SEARCH_ARTICLE:
            return ""
        case .MOST_EMAILED:
            return configuration.environment.baseURL + rawValue+configuration.environment.apiKey
        case .MOST_SHARED:
            return configuration.environment.baseURL + rawValue+configuration.environment.apiKey
        case .MOST_VIEWED:
            return configuration.environment.baseURL + rawValue+configuration.environment.apiKey
        }
    }
    
    func getSearchUrl(searchText: String)-> String{
        var configuration = Configuration()
        return "\(configuration.environment.baseURL)\(rawValue)q=\(searchText)&api-key=\(configuration.environment.apiKey)"
    }
}

