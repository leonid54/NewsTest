import UIKit
import SDWebImage

fileprivate struct Constants {
    static let contentCornerRad: CGFloat = 5
    static let defaultImage = "questionmark.folder.fill"
}

final class FeedTableViewCell: BaseTableViewCell {
    
    @IBOutlet private weak var customContentView: UIView!
    @IBOutlet private weak var feedImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var authorLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
}

private extension FeedTableViewCell {
    func configure() {
        customContentView.layer.cornerRadius = Constants.contentCornerRad
    }
}

extension FeedTableViewCell {
    func update(_ viewModel: FeedTableViewModel) {
        feedImageView.sd_setImage(with: viewModel.feed.coverURL)
        if feedImageView.image == nil {
            feedImageView.image = UIImage(systemName: Constants.defaultImage)
        }
        authorLabel.text = viewModel.author
        descriptionLabel.text = viewModel.description
        dateLabel.text = viewModel.date
    }
}
