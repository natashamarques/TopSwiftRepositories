//
//  TopListRepositoriesViewController.swift
//  TopSwiftRepositories
//
//  Created by Natasha Marques on 28/05/22.
//

import UIKit

protocol TopListRepositoriesViewProtocol {
    func reloadData()
    func showLoading()
    func removeLoading()
}

class TopListRepositoriesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let refreshControl = UIRefreshControl()
    
    var viewModel: TopListRepositoriesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchRepositories()
    }
    
    func setupView() {
        configureViewModel()
        configureActivityIndicator()
        configureNavigation()
        configureTableView()
        configurePullRefresh()
    }
    
    func configureViewModel() {
        viewModel = TopListRepositoriesViewModel()
        viewModel?.service = TopListRepositoriesService()
        viewModel?.viewController = self
        viewModel?.coordinator = TopListRepositoriesCoordinator(navigation: navigationController)
    }
    
    func configureNavigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "List of Top Repositories"
    }
    
    func configureTableView() {
        tableView.register(UINib(nibName: "TopListRepositoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "TopListRepositoriesTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureActivityIndicator() {
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.accessibilityIdentifier = "loadingView"
        activityIndicator.startAnimating()
    }
    
    func configurePullRefresh() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
         refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
         tableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        viewModel?.fetchRepositories()
    }
    
}

extension TopListRepositoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRepositories() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopListRepositoriesTableViewCell", for: indexPath) as! TopListRepositoriesTableViewCell
        cell.configureCell(repository: viewModel?.getRepositoryForIndex(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModel?.fetchMoreRepositories(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.didSelectRow(index: indexPath.row)
    }
    
}

extension TopListRepositoriesViewController: TopListRepositoriesViewProtocol {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func showLoading() {
        tableView.isHidden = true
        activityIndicator.isHidden = false
    }
    
    func removeLoading() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            self.refreshControl.endRefreshing()
            self.tableView.isHidden = false
            self.activityIndicator.isHidden = true
        }
    }
    
}
