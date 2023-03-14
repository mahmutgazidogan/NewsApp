//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Mahmut Gazi Doğan on 14.03.2023.
//

import UIKit
import Kingfisher

class NewsTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func saveModel(model: Article) {
        if model.urlToImage == nil {
            self.newsImage.kf.setImage(with: URL(string: "https://artsmidnorthcoast.com/wp-content/uploads/2014/05/no-image-available-icon-6.png"))
        } else {
            self.newsImage.kf.setImage(with: URL(string: model.urlToImage ?? ""))
        }
        self.titleLabel.text = model.title
        self.contentLabel.text = model.content
    }
    
}
