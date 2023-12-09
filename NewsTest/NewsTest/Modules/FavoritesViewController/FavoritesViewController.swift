import UIKit

final class FavoritesViewController: BaseViewController {
    
    @IBOutlet private weak var favoritesTableView: UITableView!
    
    private var model: FavoritesViewModel
        
    init(model: FavoritesViewModel) {
        self.model = model
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        configure()
    }
}

private extension FavoritesViewController {
    
    func configure() {
        setupUI()
    }
    
    func setupUI() {
        
    }
    
    func bind() {
        
    }
    
    func configureTableView() {
        favoritesTableView.delegate = self
        favoritesTableView.dataSource = self
        favoritesTableView.register(FeedTableViewCell.self,
                               forCellReuseIdentifier: FeedTableViewCell.cellIdentifierForReg)
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.output.feed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.reuseId,
                                                       for: indexPath) as? FeedTableViewCell else { return UITableViewCell() }
        cell.update(FeedTableViewModel(feed: model.output.feed[indexPath.row]))
        return cell
    }
}

extension FavoritesViewController: UITableViewDelegate, ShowDetailInterface {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let feed = model.output.feed[indexPath.row]
        showDetail(for: feed)
    }
}
