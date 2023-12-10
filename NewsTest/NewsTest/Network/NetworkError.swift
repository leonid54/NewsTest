import Foundation

fileprivate struct Constants {
    static let invalidURLTitle = "The URL provided is invalid."
    static let invalidHTTPResponseTitle = "The server responded with an unexpected status code."
    static let invalidDataTitle = "Error while receiving data"
}

enum NetworkError: LocalizedError {
    case invalidURL
    case invalidHTTPResponse
    case invalidData
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return Constants.invalidURLTitle
        case .invalidHTTPResponse:
            return Constants.invalidHTTPResponseTitle
        case .invalidData:
            return Constants.invalidDataTitle
        }
    }
}
