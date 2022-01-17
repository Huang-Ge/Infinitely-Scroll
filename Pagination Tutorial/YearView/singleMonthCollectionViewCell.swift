//
//  MonthOfYearCollectionViewCell.swift
//  Pagination Tutorial
//
//  Created by Ge Huang on 2022/1/15.
//

import UIKit

class singleMonthCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var daysInMonthCollectionView: UICollectionView!
    
    var totalSquares = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView(){
        daysInMonthCollectionView.dataSource = self
        daysInMonthCollectionView.delegate = self
        setCellsView()
    }
    
    func setCellsView()
    {
        //TODO:: Find a better way to present days
        let availableWidth = daysInMonthCollectionView.bounds.inset(by: daysInMonthCollectionView.layoutMargins).width
        //let availableHeight = dateCollectionView.bounds.inset(by: dateCollectionView.layoutMargins).height
        let width = (availableWidth / CGFloat(20)).rounded(.down)
        let height = (availableWidth / CGFloat(9)).rounded(.down)
        
        let flowLayout = daysInMonthCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
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
        monthLabel.text = CalendarHelper().monthString(date: selectedDate).prefix(3)
            + " " + CalendarHelper().yearString(date: selectedDate)
        daysInMonthCollectionView.reloadData()
        //self.tableView.reloadData()
    }
}

extension singleMonthCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalSquares.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "daysInMonthCollectionViewCell", for: indexPath) as! daysInMonthCollectionViewCell
        cell.date.text = totalSquares[indexPath.item]
        cell.date.font = UIFont.boldSystemFont(ofSize: 5.0)
        return cell
    }
    
    
}
