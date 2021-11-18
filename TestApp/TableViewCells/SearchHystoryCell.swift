//
//  SearchHystoryCell.swift
//  TestApp
//
//  Created by Marin Saca on 17.11.2021.
//

import UIKit

class SearchHystoryCell: UITableViewCell {

    @IBOutlet weak var searchTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setup(with string: String) {
        searchTitle.text = string
    }
}
