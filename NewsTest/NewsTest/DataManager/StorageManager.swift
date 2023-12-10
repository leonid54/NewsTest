import RealmSwift

let realm = try? Realm()

final class StorageManager {
    
    public static let shared = StorageManager()
    
    private init() {}
    
    func isItemSaved(item: Feed) -> Bool {
        let savedItem = realm?.objects(FeedRealmEntity.self).filter("articleID == %@", item.articleID).first
        return savedItem != nil
    }
    
    func deleteObject(_ item: Feed) {
        try? realm?.write {
            if let itemToDelete = realm?.objects(FeedRealmEntity.self).filter("articleID == %@", item.articleID).first {
                realm?.delete(itemToDelete)
            }
        }
    }
    
    func deleteFavoriteObject(_ item: FeedRealmEntity) {
        try? realm?.write {
            if let itemToDelete = realm?.objects(FeedRealmEntity.self).filter("articleID == %@", item.articleID).first {
                realm?.delete(itemToDelete)
            }
        }
    }
    
    func saveToRealm(item: Feed) {
        let realmEntity = FeedRealmEntity()
        realmEntity.articleID = item.articleID
        realmEntity.creator = item.creator?.first
        realmEntity.imageURL = item.imageURL
        realmEntity.descriptionText = item.description
        realmEntity.link = item.link
        realmEntity.pubDate = item.pubDate
        let realm = try? Realm()
        try? realm?.write {
            realm?.add(realmEntity)
        }
    }
}
