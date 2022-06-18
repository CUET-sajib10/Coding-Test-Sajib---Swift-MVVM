
import Foundation

enum Environment: String {
    case STAGING = "staging"
    case PRODUCTION = "production"
    
    var baseURL: String {
        switch self {
        case .STAGING:
            return "https://api.nytimes.com/"
        case .PRODUCTION:
            return "https://api.nytimes.com/"
        }
    }
    
    var apiKey: String {
        switch self {
        case .STAGING:
            return "J8x8gAjATzOJSqieKZkJVj9Xz7mVOkRM"
        case .PRODUCTION:
            return "J8x8gAjATzOJSqieKZkJVj9Xz7mVOkRM"
        }
    }
}

struct Configuration {
    lazy var environment: Environment = {
        if let configuration = Bundle.main.object(forInfoDictionaryKey: "Configuration") as? String {
            if configuration.range(of: "Staging") != nil {
                return Environment.STAGING
            }
        }
        return Environment.PRODUCTION
    }()
}
