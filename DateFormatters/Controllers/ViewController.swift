//
//  ViewController.swift
//  DateFormatters
//
//  Created by Karun Aggarwal on 12/06/22.
//

import UIKit

class ViewController: UIViewController {
    //: - IBoutlet
    @IBOutlet weak var labelToday: UILabel!
    @IBOutlet weak var labelFormatted: UILabel!
    @IBOutlet weak var tableview: UITableView!
    //: - Properties
    var arrayFormatters = [String]()
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }


}
extension ViewController {
    func setup() {
        self.title = "Date Formatter"
        self.labelToday.text = "Today: " + Date.init().description
        
        configure()
    }
    
    func configure() {
        tableview.dataSource = self
        tableview.delegate = self
        tableview.estimatedRowHeight = UITableView.automaticDimension
        tableview.rowHeight = UITableView.automaticDimension
        tableview.register(SubtitleCell.self, forCellReuseIdentifier: "DateFormatCell")
        
        loadFormatFromPlist()
    }
    
    func loadFormatFromPlist() {
        if let path = Bundle.main.path(forResource: "Formatters", ofType: "plist") {
            self.arrayFormatters = NSArray(contentsOfFile: path) as! [String]
            self.tableview.reloadData()
        }
    }
    
    func formatDate(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: Date())
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayFormatters.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "DateFormatCell", for: indexPath) as! SubtitleCell
        cell.textLabel?.text = self.formatDate(format: self.arrayFormatters[indexPath.row])
        cell.detailTextLabel?.text = self.arrayFormatters[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
