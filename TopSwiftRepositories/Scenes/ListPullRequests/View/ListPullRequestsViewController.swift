//
//  ListPullRequestsViewController.swift
//  TopSwiftRepositories
//
//  Created by Natasha Marques on 28/05/22.
//

import UIKit

protocol ListPullRequestsViewProtocol {
    func reloadData()
}

class ListPullRequestsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: ListPullRequestsViewModel?
    var selectedRepository: Repository
    
    init(repository: Repository) {
        selectedRepository = repository
        super.init(nibName: "ListPullRequestsViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        configureNavigationBar()
        configureTableView()
        viewModel?.fetchPullRequests()
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "List of Pull Requests"
    }
    
    func configureTableView() {
        tableView.register(UINib(nibName: "ListPullRequestsTableViewCell", bundle: nil), forCellReuseIdentifier: "ListPullRequestsTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func configureViewModel() {
        viewModel = ListPullRequestsViewModel(repository: selectedRepository)
        viewModel?.service = ListPullRequestsService()
        viewModel?.viewController = self
    }
}

extension ListPullRequestsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfPullRequests() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListPullRequestsTableViewCell", for: indexPath) as! ListPullRequestsTableViewCell
        cell.configureCell(pullRequest: viewModel?.getPullRequestForIndex(index: indexPath.row))
        return cell
    }
}

extension ListPullRequestsViewController: ListPullRequestsViewProtocol {
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}
