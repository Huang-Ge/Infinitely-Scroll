//
//  MonthViewController.swift
//  Pagination Tutorial
//
//  Created by Ge Huang on 2022/1/12.
//

import UIKit

class MonthViewController: UIViewController {
    @IBOutlet weak var monthTableView: UITableView!
    
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
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
