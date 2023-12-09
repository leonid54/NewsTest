import Foundation

final class FavoritesViewModel {
    
    struct Output {
        var feed: [Feed]
    }
    
    var output: Output
    
    init(feed: [Feed]) {
        output = Output(feed: feed)
    }
}
