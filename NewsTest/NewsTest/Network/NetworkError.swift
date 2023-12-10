import Foundation

enum NetworkError: LocalizedError {
    case invalidURL
    case invalidHTTPResponse
    case invalidData

    var errorDescription: String? {
        switch self {
            case .invalidURL:
                return "The URL provided is invalid."
            case .invalidHTTPResponse:
                return "The server responded with an unexpected status code."
        case .invalidData:
            return "Error while receiving data"
        }
    }
}
