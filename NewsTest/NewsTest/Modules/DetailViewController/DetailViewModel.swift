import Foundation

final class DetailViewModel {
    
    struct Output {
        var feed: Feed
        
        var author: String? {
            return feed.creator?.first
        }
    }
    
    var output: Output
    
    init(feed: Feed) {
        output = Output(feed: feed)
    }
}
