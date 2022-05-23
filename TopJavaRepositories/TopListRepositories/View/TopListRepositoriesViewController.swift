//
//  TopListRepositoriesViewController.swift
//  TopJavaRepositories
//
//  Created by Usertqi on 22/05/22.
//

import UIKit

protocol TopListRepositoriesViewProtocol {
    func reloadData()
}

class TopListRepositoriesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: TopListRepositoriesViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupNagigation()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.requestListRepositories()
    }
    
    func setupViewModel() {
        viewModel = TopListRepositoriesViewModel()
        viewModel?.service = TopListRepositoriesService()
        viewModel?.viewController = self
        viewModel?.coordinator = TopListRepositoriesCoordinator(navigation: navigationController)
    }
    
    func setupNagigation() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "List of repositories"
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: "TopListRepositoriesTableViewCell", bundle: nil), forCellReuseIdentifier: "TopListRepositoriesTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension TopListRepositoriesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopListRepositoriesTableViewCell", for: indexPath) as! TopListRepositoriesTableViewCell
        cell.configure(repository: viewModel?.repositoryForIndex(index: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.routePullRequests(index: indexPath.row)
    }
    
}

extension TopListRepositoriesViewController: TopListRepositoriesViewProtocol {
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

