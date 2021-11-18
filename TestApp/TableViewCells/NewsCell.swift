//
//  NewsCell.swift
//  TestApp
//
//  Created by Marin Saca on 17.11.2021.
//

import UIKit
import SDWebImage

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var contentLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup(with model: ArticleItem) {
        titleLbl.text = model.title
        contentLbl.text = model.description
        articleImage.sd_setImage(with: model.image.url)
    }
}
