//
//  monthTableViewCell.swift
//  Pagination Tutorial
//
//  Created by Ge Huang on 2022/1/13.
//

import UIKit

class monthTableViewCell: UITableViewCell {

    @IBOutlet weak var dateCollectionView: UICollectionView!
    @IBOutlet weak var monthLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        monthLabel.text = "Jan"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
