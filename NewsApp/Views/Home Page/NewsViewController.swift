//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Mahmut Gazi Doğan on 13.03.2023.
//

import UIKit

class NewsViewController: UIViewController {
    
    let newsViewModel: NewsViewModelProtocol = NewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsViewModel.fetchNews()
        
    }
    

    

}
