import UIKit

fileprivate struct Constants {
    static let defaultImage = "questionmark.folder.fill"
    static let heartImage = "heart"
    static let heartFillImage = "heart.fill"
}

final class DetailViewController: BaseViewController, BackRouting{
    
    @IBOutlet private weak var customNavBar: UIView!
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var favoriteButton: UIButton!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var scrollContentView: UIView!
    @IBOutlet private weak var authorLabel: UILabel!
    @IBOutlet private weak var contentImageView: UIImageView!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var linkLabel: UILabel!
    
    private var model: DetailViewModel
            
    init(model: DetailViewModel) {
        self.model = model
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    @IBAction private func backButtonAction(_ sender: Any) {
        goBack(animated: true)
    }
    
    @IBAction private func favoriteButtonAction(_ sender: Any) {
        model.onSetLike()
    }
}

private extension DetailViewController {
    func configure() {
        bind()
        setupUI()
    }
    
    func setupUI() {
        authorLabel.text = model.output.author
        contentImageView.sd_setImage(with: model.output.feed.coverURL)
        if contentImageView.image == nil {
            contentImageView.image = UIImage(systemName: Constants.defaultImage)
        }
        descriptionLabel.text = model.output.feed.description
        linkLabel.text = model.output.feed.link
        setFavoriteButtonImage(isLiked: model.isFavorite(item: model.output.feed))
    }
    
    func bind() {
        model.output.favoriteUpdated = { [weak self] isLiked in
            guard let self = self else { return }
            self.setFavoriteButtonImage(isLiked: isLiked)
        }
    }
    
    func setFavoriteButtonImage(isLiked: Bool) {
        favoriteButton.setImage(UIImage(systemName: isLiked ? Constants.heartFillImage : Constants.heartImage), for: .normal)
    }
}
