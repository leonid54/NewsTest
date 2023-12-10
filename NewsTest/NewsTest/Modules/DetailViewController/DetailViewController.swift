import UIKit

fileprivate struct Constants {
    static let defaultImage = "questionmark.folder.fill"
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
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction private func backButtonAction(_ sender: Any) {
        goBack(animated: true)
    }
    
    @IBAction private func favoriteButtonAction(_ sender: Any) {
        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
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
    }
    
    func bind() {
        
    }
}
