import UIKit

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
        customContentView.layer.cornerRadius = 5
    }
}

extension FeedTableViewCell {
    func update(_ viewModel: FeedTableViewModel) {
        authorLabel.text = viewModel.author
        descriptionLabel.text = viewModel.description
        dateLabel.text = viewModel.date
    }
}
