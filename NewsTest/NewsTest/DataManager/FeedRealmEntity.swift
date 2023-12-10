import Foundation
import RealmSwift

class FeedRealmEntity: Object {
    @objc dynamic var articleID: String = ""
    @objc dynamic var creator: String?
    @objc dynamic var imageURL: String?
    @objc dynamic var descriptionText: String?
    @objc dynamic var link: String = ""
    @objc dynamic var pubDate: String = ""
}

