//
//  YearViewController.swift
//  Pagination Tutorial
//
//  Created by Ge Huang on 2022/1/15.
//

import UIKit

class YearViewController: UIViewController {

    @IBOutlet weak var yearTableView: UITableView!
    private var totalYears = [Date]()
    {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.yearTableView.reloadData()
            }
        }
    }
    var currentYear: Date = Date(timeIntervalSince1970: 0)
    override func viewDidLoad() {
        super.viewDidLoad()
        yearTableView.delegate = self
        yearTableView.dataSource = self
        totalYears.append(currentYear)
        generateInitialData()
        
        

    }
    
    private func generateInitialData() {
        //let numOfYears = CalendarHelper().monthsBetweenTwoDates(previousDate: Date(timeIntervalSince1970: 0), to: Date())
        let numOfYears = 52
        for _ in 0..<(numOfYears+2) {
            let nextYearDate = CalendarHelper().plusYear(date: currentYear)
            totalYears.append(nextYearDate)
            currentYear = nextYearDate
        }
        let indexPath = IndexPath(row: numOfYears * 4, section: 0)
        yearTableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }

}

extension YearViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalYears.count * 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = yearTableView.dequeueReusableCell(withIdentifier: "threeMonthTableViewCell", for: indexPath) as! threeMonthTableViewCell
        //print("Indexpath.row: \(indexPath.row)")
        let nowYear = totalYears[indexPath.row / 4]
        let quarter = indexPath.row % 4
        //print("set up year for: \(nowYear.description), indexPath.row: \(indexPath.row), in quarter: \(quarter)")
        cell.setYearView(for: nowYear, inQuarter: quarter)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.size.height / 4.5
    }
    
}
