import Foundation

fileprivate struct Constants {
    static let apiKey = "pub_3445742a4672658564dd4a06666039808e4ac"
}

enum APIEndpoints {
    static func feed(page: String?) -> String {
        var query = "https://newsdata.io/api/1/news?apikey=\(Constants.apiKey)"
        if let page = page {
            query += "&page=\(page)"
        }
        return query
    }
}

final class RequestManager {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func downloadData(page: String?, completion: @escaping (Result<FeedData, Error>) -> Void) {
        guard let url = URL(string: APIEndpoints.feed(page: page)) else {
            dispatchToGlobal(.failure(NetworkError.invalidURL), completion: completion)
            return
        }
        
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            self?.handleResponse(data: data, response: response, error: error, completion: completion)
        }
        task.resume()
    }
    
    private func handleResponse(data: Data?,
                                response: URLResponse?,
                                error: Error?,
                                completion: @escaping (Result<FeedData, Error>) -> Void) {
        if let error = error {
            dispatchToGlobal(.failure(error), completion: completion)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            dispatchToGlobal(.failure(NetworkError.invalidHTTPResponse), completion: completion)
            return
        }
        
        guard let data = data else {
            dispatchToGlobal(.failure(NetworkError.invalidData), completion: completion)
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let feed = try decoder.decode(FeedData.self, from: data)
            dispatchToGlobal(.success(feed), completion: completion)
        } catch {
            dispatchToGlobal(.failure(error), completion: completion)
        }
    }
    
    private func dispatchToGlobal<T>(_ result: Result<T, Error>,
                                   completion: @escaping (Result<T, Error>) -> Void) {
        DispatchQueue.global().async {
            completion(result)
        }
    }
}
