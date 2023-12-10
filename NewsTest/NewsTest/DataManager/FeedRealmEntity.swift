import Foundation
import RealmSwift

final class FeedRealmEntity: Object {
    @objc dynamic var articleID: String = ""
    @objc dynamic var creator: String?
    @objc dynamic var imageURL: String?
    @objc dynamic var descriptionText: String?
    @objc dynamic var link: String = ""
    @objc dynamic var pubDate: String = ""
    
    func asFeed() -> Feed {
        return Feed(articleID: articleID, creator: [creator] as? [String], imageURL: imageURL, descriptionText: descriptionText, link: link, pubDate: pubDate)
    }
}

