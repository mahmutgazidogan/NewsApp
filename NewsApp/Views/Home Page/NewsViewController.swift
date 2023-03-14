//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Mahmut Gazi Doğan on 13.03.2023.
//

import UIKit

protocol NewsAppOutput {
    func saveDatas()
}

class NewsViewController: UIViewController {
    
    let newsViewModel: NewsViewModelProtocol = NewsViewModel()
    @IBOutlet weak var searchBar: UISearchBar! = UISearchBar()
    @IBOutlet weak var newsLabel: UILabel!
    @IBOutlet weak var newsTableView: UITableView!
    
    var makingSearch: Bool = false
    var searchedNews: [Article] = [Article]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsViewModel.fetchNews()
        setupUI()
    }
    
    private func setupUI() {
        self.newsTableView.delegate = self
        self.newsTableView.dataSource = self
        self.searchBar.delegate = self
        newsViewModel.setDelegate(output: self)
        newsViewModel.newsOutput?.saveDatas()
    }

}

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.dataList.count
    }
    
    /// didSelect buraya gelecek
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsTableViewCell else { return UITableViewCell() }
        cell.saveModel(model: newsViewModel.dataList[indexPath.row])
        return cell
    }
}

extension NewsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == " " {
            makingSearch = false
        } else {
            makingSearch = true
            searchedNews = newsViewModel.dataList.filter({ $0.title.lowercased().contains(searchText.lowercased())})
        }
        newsTableView.reloadData()
    }
}

extension NewsViewController: NewsAppOutput {
    func saveDatas() {
        newsTableView.reloadData()
    }
}
