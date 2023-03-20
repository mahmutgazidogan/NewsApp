//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Mahmut Gazi Doğan on 13.03.2023.
//

import UIKit

protocol NewsAppOutput {
    func saveDatas()
    func searchFinished()
}

class NewsViewController: UIViewController {
    
    @IBOutlet weak var newsTableView: UITableView!
    
    let newsViewModel: NewsViewModelProtocol = NewsViewModel()
    private let searchVC = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        newsViewModel.fetchNews()
        setupUI()
        createSearchBar()
        
    }
    
    private func setupUI() {
        
        title = "News"
        self.newsTableView.delegate = self
        self.newsTableView.dataSource = self
        newsViewModel.setDelegate(output: self)
        newsViewModel.newsOutput?.saveDatas()
        
    }
    
    private func createSearchBar() {
        
        searchVC.searchBar.placeholder = "Search anything..."
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
        
    }
    
}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return newsViewModel.dataList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "DetailsStoryboard", bundle: nil)
        let detailVC = storyBoard.instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
        let newsDetail = newsViewModel.dataList[indexPath.row]
        detailVC.newsDetail = newsDetail
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }
        cell.saveModel(model: newsViewModel.dataList[indexPath.row])
        return cell
    }
    
}

extension NewsViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text else {
            return
        }
        
        title = "Search Results"
        newsViewModel.makeSearch(searchTerm: text)
        newsViewModel.newsOutput?.searchFinished()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        title = "News"
        newsViewModel.fetchNews()
        newsViewModel.newsOutput?.searchFinished()
    }

}
    
extension NewsViewController: NewsAppOutput {
    
    func searchFinished() {
        self.newsTableView.reloadData()
        self.searchVC.dismiss(animated: true, completion: nil)
    }
    
    func saveDatas() {
        self.newsTableView.reloadData()
    }
    
}
