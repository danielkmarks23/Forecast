import UIKit

protocol TablePresenting: TableViewProxyPresenting {
    
    func configureOnViewLoad(_ tableViewController: TableViewController, title: String)
    func presentData(data: [Codable])
    func toggleUnitsButton()
    
    var unitsToggle: Bool { get }
}

class TablePresenter: TablePresenting {
    
    var tableView: UITableView?
    var barButtonItem: UIBarButtonItem?
    var list = [Codable]()
    let cellCreation: (IndexPath, UITableView, [Codable]) -> UITableViewCell
    let numberOfRows: ([Codable]) -> Int
    var unitsToggle = false
    
    init(cellCreation: @escaping (IndexPath, UITableView, [Codable]) -> UITableViewCell, numberOfRows: @escaping ([Codable]) -> Int) {
        
        self.cellCreation = cellCreation
        self.numberOfRows = numberOfRows
    }
    
    func configureOnViewLoad(_ tableViewController: TableViewController, title: String) {
        
        tableViewController.title = title
        let button = UIBarButtonItem(title: "°F", style: .plain, target: nil, action: nil)
        tableViewController.navigationItem.rightBarButtonItem  = button
        barButtonItem = tableViewController.navigationItem.rightBarButtonItem
        
        self.tableView = tableViewController.tableView
        tableView?.contentInset = UIEdgeInsets(top: -30, left: 0, bottom: 0, right: 0)
        tableView?.rowHeight = 72.0
        registerCells(tableViewController.tableView)
    }
    
    private func registerCells(_ tableView: UITableView) {
        
        let bundle = Bundle(for: TableViewController.self)
        
        let weatherNib = UINib(nibName: weatherTableViewCell, bundle: bundle)
        tableView.register(weatherNib, forCellReuseIdentifier: weatherTableViewCell)
    }
    
    func presentData(data: [Codable]) {
        
        print(data)
        list = data
        tableView?.reloadData()
    }
    
    func toggleUnitsButton() {
        
        if !unitsToggle {
            barButtonItem?.title = "°C"
        } else {
            barButtonItem?.title = "°F"
        }
        
        unitsToggle = !unitsToggle
    }
}

extension TablePresenter: TableViewProxyPresenting {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return numberOfRows(list)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = cellCreation(indexPath, tableView, list)
            cell.selectionStyle = .none
            return cell
    }
}
