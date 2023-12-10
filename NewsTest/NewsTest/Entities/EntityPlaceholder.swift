import Foundation

struct EntityPlaceholder {
    static func getFeedPlaceholder() -> [Feed] {
        let feed = Feed(articleID: "", creator: [], imageURL: "", descriptionText: "", link: "", pubDate: "")
        return [feed]
    }
}
