import Foundation
import RealmSwift

final class FavoritesViewModel {
    
    struct Output {
        var feed: [Feed]
        var onUpdateHandler: SimpleClosure?
    }
    
    var output: Output
    
    private let repository: FeedRepository

    init(repository: FeedRepository = FeedRealmRepository()) {
        self.repository = repository
        output = Output(feed: repository.fetchFavoriteFeed() ?? [])
    }
    
    func update() {
        let feedFromDB = repository.fetchFavoriteFeed() ?? []
        if !isFeedEqual(feed: output.feed, feedFromDB: feedFromDB) {
            output.feed = feedFromDB
            output.onUpdateHandler?()
        }
    }
}

private extension FavoritesViewModel {
    func isFeedEqual(feed: [Feed], feedFromDB: [Feed]) -> Bool {
        return feed == feedFromDB
    }
}
