//
//  ViewController.swift
//  BuyIN
//
//  Created by apple on 3/10/22.
//

import UIKit

class HomeViewController: UIViewController {


    
    let searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Search items..."
        searchController.searchBar.searchBarStyle = .minimal
        searchController.definesPresentationContext = true
        return searchController
    }()
    
    private let homeTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private lazy var homeTableViewHeader: HomeTableViewHeader = {
        let view = HomeTableViewHeader(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 350))
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarItem.image = UIImage(systemName: "house")
        tabBarItem.selectedImage = UIImage(systemName: "house.fill")

        view.addSubview(homeTableView)
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.tableHeaderView = homeTableViewHeader
        homeTableView.automaticallyAdjustsScrollIndicatorInsets = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.barStyle = .default
        navigationItem.searchController = searchController
        homeTableView.setContentOffset(CGPoint(x: 0, y: -44), animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeTableView.frame = view.frame


    }


}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Test"
        return cell
    }
}


extension HomeViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
}
