import UIKit

final class FeedViewController: BaseViewController {
    
    @IBOutlet private weak var feedTableView: UITableView!
    
    private let refreshControl = UIRefreshControl()

    private var model: FeedViewModel
        
    init(model: FeedViewModel) {
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

private extension FeedViewController {
    
    func configure() {
        setupUI()
        
    }
    
    func setupUI() {
        
    }
    
    func configureTableView() {
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.register(FeedTableViewCell.self,
                               forCellReuseIdentifier: FeedTableViewCell.cellIdentifierForReg)
        refreshControl.addTarget(self, action: #selector(refreshAction(_:)), for: .valueChanged)
        feedTableView.refreshControl = refreshControl
    }
    
    func bind() {
        
    }
    
    @objc func refreshAction(_ sender: Any) {
    }
    
}

extension FeedViewController: UITableViewDataSource {
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

extension FeedViewController: UITableViewDelegate, ShowDetailInterface {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let feed = model.output.feed[indexPath.row]
        showDetail(for: feed)
    }
}
