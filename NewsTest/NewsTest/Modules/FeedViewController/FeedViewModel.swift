import Foundation

typealias SimpleClosure = () -> Void
typealias ErrorClosure = (Error) -> Void

final class FeedViewModel {
    
    struct Output {
        var feed: [Feed]
        var nextPage: String?
        var feedLoading: SimpleClosure?
        var feedLoaded: ((_ feed: [Feed]) -> Void)?
        var onNetworkError: ErrorClosure?
    }
    
    private let feedAPIService: RequestManager

    var output: Output
    
    init(feed: [Feed], feedAPIService: RequestManager = RequestManager()) {
        output = Output(feed: feed)
        self.feedAPIService = feedAPIService
    }
    
    convenience init() {
        let placeholderFeed = EntityPlaceholder.getFeedPlaceholder()
        self.init(feed: placeholderFeed)
    }
}

extension FeedViewModel {
    
    func getFeed(page: String? = nil) {
        feedAPIService.downloadData(page: page) { [weak self] result in
            self?.output.feedLoading?()
            switch result {
            case .success(let response):
                self?.output.nextPage = response.nextPage
                self?.output.feedLoaded?(response.results)
            case .failure(let error):
                self?.output.onNetworkError?(error)
            }
        }
    }
}
