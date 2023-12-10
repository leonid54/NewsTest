import Foundation

final class DetailViewModel {
    
    struct Output {
        var feed: Feed
        var favoriteUpdated: ((_ isFavorite: Bool) -> Void)?
        
        var author: String? {
            return feed.creator?.first
        }
        
        var isLiked = false {
            didSet {
                if oldValue != isLiked {
                    favoriteUpdated?(isLiked)
                }
            }
        }
    }
    
    var output: Output
    var storage: StorageManager
    
    init(feed: Feed, storage: StorageManager = .shared) {
        output = Output(feed: feed)
        self.storage = storage
        output.isLiked = isFavorite(item: output.feed)
    }
}

extension DetailViewModel {
    
    func onSetLike() {
        if isFavorite(item: output.feed) {
            storage.deleteObject(output.feed)
            output.isLiked.toggle()
        } else {
            storage.saveToRealm(item: output.feed)
            output.isLiked.toggle()
        }
    }
    
    func isFavorite(item: Feed) -> Bool {
        return storage.isItemSaved(item: item)
    }
}
