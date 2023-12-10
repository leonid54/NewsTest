import Foundation
import RealmSwift

protocol FeedRepository {
    func fetchFavoriteFeed() -> [Feed]?
}

final class FeedRealmRepository: FeedRepository {
    
    private var realm: Realm?

    init(realm: Realm? = try? Realm()) {
        self.realm = realm
    }
    
    func fetchFavoriteFeed() -> [Feed]? {
        return realm?.objects(FeedRealmEntity.self).map { $0.asFeed()}
    }
}
