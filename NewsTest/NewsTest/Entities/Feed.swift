import Foundation

struct FeedData: Decodable {
    let results: [Feed]
    let nextPage: String
}

struct Feed: Decodable {
    let articleID: String
    let creator: [String]?
    let imageURL: String?
    let descriptionText: String?
    let link: String
    let pubDate: String

     enum CodingKeys: String, CodingKey {
         case articleID = "article_id"
         case creator
         case imageURL = "image_url"
         case descriptionText = "description"
         case link
         case pubDate
     }
    
    var coverURL: URL? {
        guard let url = imageURL else { return nil }
        return URL(string: url)
    }
}
