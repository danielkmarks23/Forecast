import UIKit

class TableCoordinator {
    
    weak var tableViewController: TableViewController?
    var tableViewProxy: SelfSizingTableViewProxy?
    let presenter: TablePresenting
    let responder: TableResponding
    let dataStore: TableDataStoring
    var name: String
    var appDelegate: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    required init(presenter: TablePresenting,
                  responder: TableResponding,
                  dataStore: TableDataStoring,
                  name: String) {
        
        self.presenter = presenter
        self.responder = responder
        self.dataStore = dataStore
        self.name = name

        configureOnInit()
    }
    
    private func configureOnInit() {
        
        responder.didSelectRow = { [weak self] indexPath in
            self?.indexPathSelected(indexPath: indexPath)
        }
        
        responder.didTapUnitsButton = { [weak self] in
            
            self?.toggleUnitsButton()
        }
    }
    
    private func toggleUnitsButton() {
        
        self.presenter.toggleUnitsButton()
        
        if appDelegate.currentUnits == .metric {
            appDelegate.currentUnits = .imperial
        } else {
            appDelegate.currentUnits = .metric
        }
        
        load()
    }
    
    private func configureOnViewLoad(tableViewController: TableViewController) {
        
        self.tableViewController = tableViewController
        
        tableViewProxy = SelfSizingTableViewProxy(presenter: presenter, responder: responder)
        tableViewController.tableView.dataSource = tableViewProxy
        tableViewController.tableView.delegate = tableViewProxy
        
        presenter.configureOnViewLoad(tableViewController, title: name != "" ? name : "Cities")
        responder.configureOnViewLoad(tableViewController)
        
        load()
    }
    
    private func load() {
        
        if name != "" {
            loadDailyWeather()
        } else {
            loadCities()
        }
    }
    
    private func loadCities() {
        
        dataStore.load(arg: nil, completion: { [unowned self] data in
            
            if let cities = data as? [City] {
                DispatchQueue.main.async {
                    self.presenter.presentData(data: cities)
                }
            }
            }, catchError: { error in
                print(error)
        })
    }
    
    private func loadDailyWeather() {
        
        dataStore.load(arg: name, completion: { [unowned self] data in
            
            if let weatherArray = data as? [DailyWeather] {
                DispatchQueue.main.async {
                    self.presenter.presentData(data: weatherArray)
                }
            }
            }, catchError: { error in
                print(error)
        })
    }
    
    private func indexPathSelected(indexPath: IndexPath) {
        
        if let city = dataStore.array[indexPath.row] as? City {
            
            let viewController = appDelegate.assembler.dailyWeatherViewController(name: city.name)
            self.tableViewController?.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
    func viewControllerViewDidLoad(tableViewController: TableViewController) {
        
        configureOnViewLoad(tableViewController: tableViewController)
    }
}
