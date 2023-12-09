import Foundation

final class DetailViewModel {
    
    struct Output {
        var feed: Feed
    }
    
    var output: Output
    
    init(feed: Feed) {
        output = Output(feed: feed)
    }
}
