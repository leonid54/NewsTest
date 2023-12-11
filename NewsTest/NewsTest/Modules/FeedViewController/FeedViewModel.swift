import Foundation

typealias SimpleClosure = () -> Void
typealias ErrorClosure = (Error) -> Void

final class FeedViewModel {
    
    struct Output {
        var feed: [Feed]
        var nextPage: String?
        var feedLoading: SimpleClosure?
        var feedLoaded: ((_ isLoading: Bool) -> Void)?
        var onNetworkError: ErrorClosure?
    }
    
    private let feedAPIService: RequestManager

    var output: Output
    
    init(feed: [Feed], feedAPIService: RequestManager = RequestManager()) {
        output = Output(feed: feed)
        self.feedAPIService = feedAPIService
    }
    
    convenience init() {
        self.init(feed: [])
    }
}

extension FeedViewModel {
    
    func getFeed(page: String? = nil) {
        feedAPIService.downloadData(page: page) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.output.feedLoading?()
                switch result {
                case .success(let response):
                    self.output.nextPage = response.nextPage
                    self.output.feed.append(contentsOf: response.results)
                    self.output.feedLoaded?(false)
                case .failure(let error):
                    self.output.onNetworkError?(error)
                }
            }
        }
    }
}
