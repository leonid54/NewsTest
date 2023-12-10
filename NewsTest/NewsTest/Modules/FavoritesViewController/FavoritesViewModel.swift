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
        let dataBase = repository.fetchFavoriteFeed() ?? []
        if !Feed.checkEqual(feed: output.feed, dataBase: dataBase) {
            output.feed = dataBase
            output.onUpdateHandler?()
        }
    }
}
