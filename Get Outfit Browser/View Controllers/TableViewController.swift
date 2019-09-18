//
//  TableViewController.swift
//  Get Outfit Browser
//
//  Created by Denis Bystruev on 18/09/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    let cellController = CellController()
    let categoryNetworkController = NetworkController<YMLCategory>("http://server.getoutfit.ru/categories")!
    let offerNetworkController = NetworkController<YMLOffer>("http://server.getoutfit.ru/offers")!
    
    var rootElement: Named?
    var elements = [Named]() {
        didSet {
            #if DEBUG
            print(#line, #function, elements)
            #endif
        }
    }
}

// MARK: - UIViewController
extension TableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = rootElement?.name ?? "Get Outfit"
        
        categoryNetworkController.getMany(["parentId": rootElement?.getId]) { categories, error in
            guard let categories = categories else {
                #if DEBUG
                print(#line, #function, "ERROR:", error?.localizedDescription ?? "nil")
                #endif
                
                return
            }
            self.elements = categories
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension TableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cellController.configure(cell, with: elements[indexPath.row])
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
        let viewController = storyboard?.instantiateViewController(withIdentifier: "TableViewController")
        guard let tableViewController = viewController as? TableViewController else { return }
        tableViewController.rootElement = elements[selectedIndexPath.row]
        navigationController?.pushViewController(tableViewController, animated: true)
    }
}