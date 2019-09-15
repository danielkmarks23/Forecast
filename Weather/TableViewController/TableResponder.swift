//
//  TableResponder.swift
//  Weather
//
//  Created by Daniel Marks on 06/08/2019.
//  Copyright © 2019 Daniel Marks. All rights reserved.
//

import UIKit

protocol TableResponding: TableViewProxyResponding {
    
    var didSelectRow: ((IndexPath) -> Void)? { get set }
    var didTapUnitsButton: (() -> Void)? { get set }
    
    func configureOnViewLoad(_ viewController: UIViewController)
}

class TableResponder: TableResponding {
    
    var didSelectRow: ((IndexPath) -> Void)?
    var didTapUnitsButton: (() -> Void)?
    
    func configureOnViewLoad(_ viewController: UIViewController) {
        
        viewController.navigationItem.rightBarButtonItem?.target = self
        viewController.navigationItem.rightBarButtonItem?.action = #selector(tappedUnitsButton)
    }
    
    @objc func tappedUnitsButton() {
        
        didTapUnitsButton?()
    }
}

extension TableResponder: TableViewProxyResponding {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        didSelectRow?(indexPath)
    }
}
