//
//  StackViewCell.swift
//  Pagination Tutorial
//
//  Created by Ge Huang on 2022/1/11.
//

import UIKit

class StackViewCell: UITableViewCell {

    @IBOutlet weak var monthLabel: UITableViewCell!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
