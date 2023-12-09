import UIKit

final class DetailViewController: BaseViewController {
    
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
        bind()
    }
    
    @IBAction private func backButtonAction(_ sender: Any) {
    }
    
    @IBAction private func favoriteButtonAction(_ sender: Any) {
        favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
    }
}

private extension DetailViewController {
    func configure() {
        
    }
    
    func bind() {
        
    }
}
