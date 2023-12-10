import Foundation
import RealmSwift

final class FavoritesViewModel {
    
    struct Output {
        var feed: [Feed]
    }
    
    var output: Output
    
    private let repository: FeedRepository

    init(repository: FeedRepository = FeedRealmRepository()) {
        self.repository = repository
        output = Output(feed: repository.fetchFavoriteFeed() ?? [])
    }
    
    func update() {
        output.feed = repository.fetchFavoriteFeed() ?? []
    }
}
