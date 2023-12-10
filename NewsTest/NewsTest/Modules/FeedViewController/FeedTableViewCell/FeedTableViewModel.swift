import Foundation

struct FeedTableViewModel {
        
    let feed: Feed
    
    var image: String? {
        return feed.imageURL
    }
    
    var description: String? {
        return feed.descriptionText
    }
    
    var date: String? {
        return feed.pubDate
    }
    
    var author: String? {
        return feed.creator?.first
    }
}
