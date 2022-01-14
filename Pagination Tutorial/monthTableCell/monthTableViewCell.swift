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
    // things to try to set up the days
    //var selectedDate = Date()
    var totalSquares = [String]()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateCollectionView.dataSource = self
        dateCollectionView.delegate = self
        setCellsView()
        //setMonthView()
        
    }
    
    func setCellsView()
    {
        //TODO:: Find a better way to present days
        let availableWidth = dateCollectionView.bounds.inset(by: dateCollectionView.layoutMargins).width
        //let availableHeight = dateCollectionView.bounds.inset(by: dateCollectionView.layoutMargins).height
        let width = (availableWidth / CGFloat(9)).rounded(.down)
        let height = (availableWidth / CGFloat(9)).rounded(.down)
        
        let flowLayout = dateCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    
    func setMonthView(for selectedDate: Date)
    {
        totalSquares.removeAll()
        
        let daysInMonth = CalendarHelper().daysInMonth(date: selectedDate)
        let firstDayOfMonth = CalendarHelper().firstOfMonth(date: selectedDate)
        let startingSpaces = CalendarHelper().weekDay(date: firstDayOfMonth)
        
        var count: Int = 1
        
        while(count <= 42)
        {
            if(count <= startingSpaces || count - startingSpaces > daysInMonth) //find whether count is within this month
            {
                totalSquares.append("")
            }
            else
            {
                totalSquares.append(String(count - startingSpaces))
            }
            count += 1
        }
        //remove the first empty row
        //print(totalSquares)
        if totalSquares[6] == "" {
            print("remove something now...")
            for _ in 0..<7 { totalSquares.removeFirst()}
        }
        monthLabel.text = CalendarHelper().monthString(date: selectedDate)
            + " " + CalendarHelper().yearString(date: selectedDate)
        dateCollectionView.reloadData()
        //self.tableView.reloadData()
    }
    //add a function to display the month view

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension monthTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalendarTableViewCell", for: indexPath) as! CalendarTableViewCell
        cell.dayOfMonth.text = totalSquares[indexPath.item]
        return cell
    }
    
    
}
