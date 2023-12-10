import Foundation
import RealmSwift

protocol FeedRepository {
    func fetchFavoriteFeed() -> Results<FeedRealmEntity>?
}

final class FeedRealmRepository: FeedRepository {
    
    private var realm: Realm?

    init(realm: Realm? = try? Realm()) {
        self.realm = realm
    }
    
    func fetchFavoriteFeed() -> Results<FeedRealmEntity>? {
        return realm?.objects(FeedRealmEntity.self)
    }
}
