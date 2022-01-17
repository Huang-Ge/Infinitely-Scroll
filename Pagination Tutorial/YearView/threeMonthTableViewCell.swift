//
//  TableViewCell.swift
//  Pagination Tutorial
//
//  Created by Ge Huang on 2022/1/15.
//

import UIKit

class threeMonthTableViewCell: UITableViewCell {
    @IBOutlet weak var monthCollectionView: UICollectionView!
    var monthsInQuarter = [Date]()
    {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.monthCollectionView.reloadData()
            }
        }
    }
    
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
        let availableHeight = monthCollectionView.bounds.inset(by: monthCollectionView.layoutMargins).height
        let width = ((availableWidth + 70) / CGFloat(4)).rounded(.down)
        let height = ((availableHeight + 100) / CGFloat(1)).rounded(.down)
        
        let flowLayout = monthCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    func setYearView(for selectedDate: Date, inQuarter quarter: Int)
    {
        //Date starts from January
        monthsInQuarter.removeAll()
        let monthsToAdd = 3 * quarter
        var currentMonth = selectedDate
        //print("before set up month for: \(currentMonth.description), monthsToAdd: \(monthsToAdd) in quarter: \(quarter)")
        for _ in 0..<monthsToAdd { currentMonth = CalendarHelper().plusMonth(date: currentMonth) }
        //print("after set up month for: \(currentMonth.description), monthsToAdd: \(monthsToAdd) in quarter: \(quarter)")
        for _ in 0..<3
        {
            monthsInQuarter.append(currentMonth)
            currentMonth = CalendarHelper().plusMonth(date: currentMonth)
        }
        //print("after set up month for: \(currentMonth.description), in quarter: \(quarter)")


        monthCollectionView.reloadData()
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
        cell.setMonthView(for: monthsInQuarter[indexPath.item])
        //print("current monthsInQuarter: \(monthsInQuarter)")
        //print("Displaying number \(indexPath.item) of Month in Cell: \(monthsInQuarter[indexPath.item])")
        return cell
    }
    
    //func collectionView
    
}
