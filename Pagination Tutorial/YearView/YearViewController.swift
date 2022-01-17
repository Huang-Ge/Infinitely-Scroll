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
    enum TableSection: Int {
        case dateList
        case loader
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
    
    private func fetchData() {
        for _ in 0..<3 {
            let nextYear = CalendarHelper().plusYear(date: currentYear)
            totalYears.append(nextYear)
            currentYear = nextYear
        }
    }

}

extension YearViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let listSection = TableSection(rawValue: section) else { return 0 }
        switch listSection {
        case .dateList:
            return totalYears.count * 4
        case .loader:
            return 1
        }
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
        return 2
    }
    
    // fetch generated data
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let section = TableSection(rawValue: indexPath.section) else { return }
        guard !totalYears.isEmpty else { return }

        if section == .loader {
            fetchData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.size.height / 4.5
    }
    
}
