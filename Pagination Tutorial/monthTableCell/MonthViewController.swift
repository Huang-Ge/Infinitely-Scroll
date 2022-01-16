//
//  MonthViewController.swift
//  Pagination Tutorial
//
//  Created by Ge Huang on 2022/1/12.
//

import UIKit

class MonthViewController: UIViewController {
    @IBOutlet weak var monthTableView: UITableView!
    let pageLimit = 2
    var selectedDate = Date(timeIntervalSince1970: 0)
    private var totalMonths = [Date](){
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.monthTableView.reloadData()
            }
        }
    }
    
    enum TableSection: Int {
        case dateList
        case loader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()

    }
    
    private func setupView() {
        title = "Months"
        //tableView.rowHeight = 64
        totalMonths.append(selectedDate)
        generateInitialData()
        monthTableView.dataSource = self
        monthTableView.delegate = self
        let now = Date()
        let numOfMonths = CalendarHelper().monthsBetweenTwoDates(previousDate: Date(timeIntervalSince1970: 0), to: now)
        if totalMonths.count > numOfMonths{
            let indexPath = IndexPath(row: numOfMonths, section: 0)
            monthTableView.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    private func generateInitialData() {
        for _ in 0..<630 {
            let nextMonthDate = CalendarHelper().plusMonth(date: selectedDate)
            totalMonths.append(nextMonthDate)
            selectedDate = nextMonthDate
        }
    }
    
    private func fetchData() {
        for _ in 0..<3 {
            let nextMonthDate = CalendarHelper().plusMonth(date: selectedDate)
            totalMonths.append(nextMonthDate)
            selectedDate = nextMonthDate
        }
    }
}

extension MonthViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO:: pass the data to monthTableViewCell
        
        guard let cell = monthTableView.dequeueReusableCell(withIdentifier: "monthTableViewCell", for: indexPath) as? monthTableViewCell else { fatalError("Unable to create Table View Cell") }
        let currentMonth = totalMonths[indexPath.row]
        cell.setMonthView(for: currentMonth)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    // fetch generated data
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let section = TableSection(rawValue: indexPath.section) else { return }
        guard !totalMonths.isEmpty else { return }

        if section == .loader {
            fetchData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let listSection = TableSection(rawValue: section) else { return 0 }
        switch listSection {
        case .dateList:
            return totalMonths.count
        case .loader:
            return totalMonths.count >= pageLimit ? 1 : 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.size.height / 3
    }
}
