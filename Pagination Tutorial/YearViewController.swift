//
//  ViewController.swift
//  Pagination Tutorial
//
//  Created by Ge Huang on 2022/1/8.
//

import UIKit

class ViewController: UIViewController {
    // 1
        enum TableSection: Int {
            case dateList
            case loader
        }
    @IBOutlet weak var tableView: UITableView!
    // 2
        private let pageLimit = 25
        private var currentYear: Int = 1970 //start from 1970
        
        private var dates = [selfDefinedDate]() {
            didSet {
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
            }
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupView()
            fetchData()
        }
        
        private func setupView() {
            title = "Years"
            tableView.rowHeight = 64
            tableView.dataSource = self
            tableView.delegate = self
        }
        
        // 3
        private func fetchData() {
            let data = DateManager.shared.getDate(sinceDate: currentYear)
            dates.append(contentsOf: data)
            guard let year = dates.last?.year else { return  }
            self.currentYear = year + 1
        }
    }

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    // 7
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 8
        guard let listSection = TableSection(rawValue: section) else { return 0 }
        switch listSection {
        case .dateList:
            return dates.count
        case .loader:
            return dates.count >= pageLimit ? 1 : 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //guard let section = TableSection(rawValue: indexPath.section) else { return UITableViewCell() }
        //show data on the cell
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "Cell")
        // 9
        let repo = dates[indexPath.row]
        cell.textLabel?.text = String(repo.year)
        cell.detailTextLabel?.text = "\(indexPath.row + 1)"
        return cell
    }
    
    // fetch generated data
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let section = TableSection(rawValue: indexPath.section) else { return }
        guard !dates.isEmpty else { return }

        if section == .loader {
            print("load new data..")
            fetchData()
        }
    }
    // create loading view
    private func hideBottomLoader() {
        DispatchQueue.main.async {
            let lastListIndexPath = IndexPath(row: self.dates.count - 1, section: TableSection.dateList.rawValue)
            self.tableView.scrollToRow(at: lastListIndexPath, at: .bottom, animated: true)
        }
    }
}

