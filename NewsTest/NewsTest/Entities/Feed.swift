import Foundation

struct Feed: Decodable {
    let articleID: String
    let creator: [String]
    let imageURL: String
    let description: String
    let link: String
    let pubDate: String

     enum CodingKeys: String, CodingKey {
         case articleID = "article_id"
         case creator
         case imageURL = "image_url"
         case description
         case link
         case pubDate
     }
}
