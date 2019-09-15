import UIKit

class TableAssembler {
    
    var manager = WeatherManager()
    
    func citiesViewController() -> TableViewController {
        
        let dataStore = CitiesTableDataStore(manager: manager)
        
        let numberOfRows: ([Codable]) -> Int = { list in
            
            return list.count
        }
        
        let cellCreation: (IndexPath, UITableView, [Codable]) -> UITableViewCell = { indexPath, tableView, items in
            
             if let cell = tableView.dequeueReusableCell(withIdentifier: weatherTableViewCell, for: indexPath) as? WeatherTableViewCell, let city = items[indexPath.row] as? City {
                
                
                let cellViewModel = WeatherTableViewCellViewModel(city: city)
                cell.setup(with: cellViewModel)
                return cell
            }
            
            return UITableViewCell()
        }
        
        let presenter = TablePresenter(cellCreation: cellCreation, numberOfRows: numberOfRows)
        return tableViewController(dataStore: dataStore, presenter: presenter)
    }
    
    func dailyWeatherViewController(name: String) -> TableViewController {
        
        let dataStore = DailyWeatherTableDataStore(manager: manager)
        
        let numberOfRows: ([Codable]) -> Int = { list in
            
            return list.count / 8
        }
        
        let cellCreation: (IndexPath, UITableView, [Codable]) -> UITableViewCell = { indexPath, tableView, items in
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: weatherTableViewCell, for: indexPath) as? WeatherTableViewCell, let dailyWeather = items[indexPath.row * 8] as? DailyWeather {
                
                let cellViewModel = WeatherTableViewCellViewModel(dailyWeather: dailyWeather)
                cell.setup(with: cellViewModel)
                return cell
            }
            
            return UITableViewCell()
        }
        
        let presenter = TablePresenter(cellCreation: cellCreation, numberOfRows: numberOfRows)
        return tableViewController(dataStore: dataStore, presenter: presenter, name: name)
    }
    
    private func tableViewController(dataStore: TableDataStoring,
                                     presenter: TablePresenting,
                                     name: String = "") -> TableViewController {
        
        let responder = TableResponder()
        
        let coordinator = TableCoordinator(presenter: presenter,
                                           responder: responder,
                                           dataStore: dataStore,
                                           name: name)
        let viewController = TableViewController(coordinator: coordinator)
        
        return viewController
    }
}
