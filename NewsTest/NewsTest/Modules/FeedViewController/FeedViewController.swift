import UIKit

fileprivate struct Constants {
    static let indicatorColor: UIColor = .white
    static let spinnerHeight: CGFloat = 44
    static let spinnerRect: CGFloat = 0
}

final class FeedViewController: BaseViewController {
    
    @IBOutlet private weak var feedTableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    private let spinner = UIActivityIndicatorView(style: .large)

    private var model: FeedViewModel
    private var isLoading = false
        
    init(model: FeedViewModel) {
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
}

private extension FeedViewController {
    
    func configure() {
        configureTableView()
        bind()
        setupUI()
    }
    
    func configureTableView() {
        feedTableView.delegate = self
        feedTableView.dataSource = self
        feedTableView.register(FeedTableViewCell.uiNib,
                               forCellReuseIdentifier: FeedTableViewCell.cellIdentifierForReg)
        refreshControl.addTarget(self, action: #selector(refreshAction(_:)), for: .valueChanged)
        feedTableView.refreshControl = refreshControl
    }
    
    func setupUI() {
        refreshControl.tintColor = Constants.indicatorColor
        spinner.frame = CGRect(x: Constants.spinnerRect, y: Constants.spinnerRect, width: feedTableView.bounds.width, height: Constants.spinnerHeight)
        feedTableView.tableFooterView = spinner
    }
    
    func showLoading() {
        spinner.startAnimating()
        feedTableView.tableFooterView?.isHidden = false
    }
    
    func hideLoading() {
        spinner.stopAnimating()
        feedTableView.tableFooterView?.isHidden = true
    }
    
    func bind() {
        model.output.onNetworkError = { [weak self] error in
            guard let self else { return }
            self.showToast(message: error.localizedDescription)
        }
        
        model.output.feedLoading = { [weak self] in
            guard let self else { return }
            self.refreshControl.beginRefreshing()
        }
        
        model.output.feedLoaded = { [weak self] isLoading in
            guard let self else { return }
            self.feedTableView.reloadData()
            self.refreshControl.endRefreshing()
            self.isLoading = isLoading
            self.hideLoading()
        }
    }
    
    @objc func refreshAction(_ sender: Any) {
        model.getFeed(page: model.output.nextPage)
    }
    
}

extension FeedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.output.feed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FeedTableViewCell.cellIdentifierForReg,
                                                       for: indexPath) as? FeedTableViewCell else { return UITableViewCell() }
        cell.update(FeedTableViewModel(feed: model.output.feed[indexPath.row]))
        return cell
    }
}

extension FeedViewController: UITableViewDelegate, ShowDetailInterface {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let feed = model.output.feed[indexPath.row]
        showDetail(for: feed, hidesBottomBarWhenPushed: true)
    }
    
    func scrollViewDidScroll(_: UIScrollView) {
        checkForNextPage()
    }
    
    private func checkForNextPage() {
        let scrollViewContentHeight = feedTableView.contentSize.height
        let scrollOffsetThreshold = scrollViewContentHeight - feedTableView.bounds.height
        if feedTableView.contentOffset.y > scrollOffsetThreshold {
            triggerBottomRefresh()
        }
    }
    
    private func triggerBottomRefresh() {
        if !isLoading {
            showLoading()
            isLoading = true
            model.getFeed(page: model.output.nextPage)
        }
    }
}
