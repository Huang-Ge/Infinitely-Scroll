//
//  YearViewController.swift
//  Pagination Tutorial
//
//  Created by Ge Huang on 2022/1/15.
//

import UIKit

class YearViewController: UIViewController {

    @IBOutlet weak var yearTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        yearTableView.delegate = self
        yearTableView.dataSource = self

    }

}

extension YearViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = yearTableView.dequeueReusableCell(withIdentifier: "threeMonthTableViewCell", for: indexPath) as! threeMonthTableViewCell
        print("Displaying threeMonthTableViewCell")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.size.height * 2
    }
    
}
