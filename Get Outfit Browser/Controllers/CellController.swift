//
//  CellController.swift
//  Get Outfit Browser
//
//  Created by Denis Bystruev on 18/09/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import SDWebImage
import UIKit

class CellController {
    func configure(_ cell: UITableViewCell, in tableView: UITableView, with category: YMLCategory) {
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = category.name
        cell.detailTextLabel?.text = "Category id: \(category.getId)"
    }
    
    func configure(_ cell: UITableViewCell, in tableView: UITableView, with offer: YMLOffer) {
        cell.textLabel?.text = offer.title
        cell.detailTextLabel?.text = "\(offer.price) ₽"
        if let imageURL = offer.pictures.first {
            cell.imageView?.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "icons8-jumper"))
        }
    }
    
    func configure(_ cell: UITableViewCell, in tableView: UITableView, with element: Codable) {
        if let category = element as? YMLCategory {
            configure(cell, in: tableView, with: category)
        } else if let offer = element as? YMLOffer {
            configure(cell, in: tableView, with: offer)
        }
    }
    
    func identifier(for element: Codable) -> String {
        switch element {
        case is YMLCategory:
            return "CategoryCell"
        case is YMLOffer:
            return "OfferCell"
        default:
            return "Cell"
        }
    }
}
