//
//  ListViewController.swift
//  Get Outfit Browser
//
//  Created by Denis Bystruev on 18/09/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {
    let cellController = CellController()
    let categoryNetworkController = NetworkController<YMLCategory>("http://server.getoutfit.ru/categories")!
    let offerNetworkController = NetworkController<YMLOffer>("http://server.getoutfit.ru/offers")!
    
    var rootElement: Named?
    var elements = [Named]()
}

// MARK: - UI
extension ListViewController {
    func updateTitle() {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.text = rootElement?.name ?? "Get Outfit"
        navigationItem.titleView = label
    }
    
    func updateUI() {
        categoryNetworkController.getMany(["parentId": rootElement?.getId]) { categories, error in
            guard let categories = categories else {
                #if DEBUG
                print(#line, #function, "ERROR:", error?.localizedDescription ?? "nil")
                #endif
                
                return
            }
            self.elements = categories
            
            self.offerNetworkController.getMany([
                "available": "\(true)",
                "categoryId": self.rootElement?.getId
            ]) { offers, error in
                guard let offers = offers else {
                    #if DEBUG
                    print(#line, #function, "ERROR:", error?.localizedDescription ?? "nil")
                    #endif
                    
                    return
                }
                
                self.elements += offers
                
                guard categories.count != 1 || 0 < offers.count else {
                    #if DEBUG
                    let category = categories[0]
                    print(#line, #function, "Skipping id \(category.getId): \(category.name)")
                    #endif
                    
                    self.rootElement = self.elements.first
                    self.updateUI()
                    return
                }
                
                DispatchQueue.main.async {
                    self.updateTitle()
                    self.tableView.reloadData()
                }
            }
        }
    }
}

// MARK: - UIViewController
extension ListViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
}

// MARK: - UITableViewDataSource
extension ListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let element = elements[indexPath.row]
        let identifier = cellController.identifier(for: element)
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cellController.configure(cell, in: tableView, with: element)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ListViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
        guard let category = elements[selectedIndexPath.row] as? YMLCategory else { return }
        let viewController = storyboard?.instantiateViewController(withIdentifier: "ListViewController")
        guard let tableViewController = viewController as? ListViewController else { return }
        tableViewController.rootElement = category
        navigationController?.pushViewController(tableViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}

// MARK: - Navigation
extension ListViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "DetailViewControllerSegue" else { return }
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        guard let offer = elements[indexPath.row] as? YMLOffer else { return }
        guard let destination = segue.destination as? OfferViewController else { return }
        destination.offer = offer
    }
}
