//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Mahmut Gazi Doğan on 14.03.2023.
//

import UIKit
import Kingfisher

class NewsTableViewCellViewModel {
    
    let title: String
    let subtitle: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(title: String, subtitle: String, imageURL: URL?) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
        
    }
}

class NewsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func saveModel(model: Article) {
        
        guard let imageURL = model.urlToImage else {
            self.newsImage.kf.setImage(with: URL(string: "https://artsmidnorthcoast.com/wp-content/uploads/2014/05/no-image-available-icon-6.png"))
            return
        }
        
        self.newsImage.kf.setImage(with: URL(string: imageURL))
        self.titleLabel.text = model.title
        self.contentLabel.text = model.content
        
    }
    
}
