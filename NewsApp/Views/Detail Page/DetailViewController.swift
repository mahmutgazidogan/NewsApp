//
//  DetailViewController.swift
//  NewsApp
//
//  Created by Mahmut Gazi Doğan on 14.03.2023.
//

import UIKit
import Kingfisher
import SafariServices

class DetailViewController: UIViewController {

    @IBOutlet weak var bigNewsImage: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var contentTitle: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    var newsDetail: Article?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    func setupUI() {
        
        title = "News Details"
        bigNewsImage.kf.setImage(with: URL(string: newsDetail?.urlToImage ?? ""))
        
        if newsDetail?.author == nil {
            authorLabel.text = "Author has not found!"
        } else {
            authorLabel.text = "Author: \(newsDetail?.author ?? "")"
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let result = dateFormatter.date(from: newsDetail?.publishedAt ?? "")
        dateFormatter.dateFormat = "MM-dd-yyyy HH:mm"
        let convertedDate = dateFormatter.string(from: result ?? Date())
        
        contentLabel.text = newsDetail?.content
        dateLabel.text = "Date: \(convertedDate)"
        
    }
    
    @IBAction func websiteButton(_ sender: Any) {
        
        guard let url = URL(string: newsDetail?.url ?? "") else {
            return
        }
        
        let webSite = SFSafariViewController(url: url)
        self.present(webSite, animated: true)
        
    }
    
}
