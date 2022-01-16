//
//  TableViewCell.swift
//  Pagination Tutorial
//
//  Created by Ge Huang on 2022/1/15.
//

import UIKit

class threeMonthTableViewCell: UITableViewCell {
    @IBOutlet weak var monthCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
        setCellsView()
    }
    
    func setupView() {
        monthCollectionView.dataSource = self
        monthCollectionView.delegate = self
    }
    
    func setCellsView()
    {
        //TODO:: Find a better way to present days
        let availableWidth = monthCollectionView.bounds.inset(by: monthCollectionView.layoutMargins).width
        //let availableHeight = dateCollectionView.bounds.inset(by: dateCollectionView.layoutMargins).height
        let width = (availableWidth / CGFloat(3)).rounded(.down)
        let height = (availableWidth / CGFloat(3)).rounded(.down)
        
        let flowLayout = monthCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension threeMonthTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "singleMonthCollectionViewCell", for: indexPath) as! singleMonthCollectionViewCell
        cell.setMonthView(for: Date())
        print("Displaying singleMonthCollectionViewCell")
        return cell
    }
    
    
}
