import Foundation

typealias SimpleClosure = () -> Void

final class FeedViewModel {
    
    struct Output {
        var feed: [Feed]
    }
    
    var output: Output
    
    init(feed: [Feed]) {
        output = Output(feed: feed)
    }
}
