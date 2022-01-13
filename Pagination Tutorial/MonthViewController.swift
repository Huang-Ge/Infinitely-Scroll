//
//  MonthViewController.swift
//  Pagination Tutorial
//
//  Created by Ge Huang on 2022/1/12.
//

import UIKit

class MonthViewController: UIViewController {
    @IBOutlet weak var monthTableView: UITableView!
    private var months = [monthViewData]() {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.monthTableView.reloadData()
            }
        }
    }
    
    let pageLimit = 2
    
    enum TableSection: Int {
        case dateList
        case loader
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension MonthViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = monthTableView.dequeueReusableCell(withIdentifier: "monthTableViewCell", for: indexPath) as? monthTableViewCell else { fatalError("Unable to create Table View Cell") }
        return cell
    }
    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 2
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
//        guard let listSection = TableSection(rawValue: section) else { return 0 }
//        switch listSection {
//        case .dateList:
//            return months.count
//        case .loader:
//            return months.count >= pageLimit ? 1 : 0
//        }
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 140
//    }
}
