//
//  CellController.swift
//  Get Outfit Browser
//
//  Created by Denis Bystruev on 18/09/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class CellController {
    func configure(_ cell: UITableViewCell, with category: YMLCategory) {
        cell.textLabel?.text = category.name
        cell.detailTextLabel?.text = "id: \(category.id)"
    }
    
    func configure(_ cell: UITableViewCell, with offer: YMLOffer) {
        cell.textLabel?.text = offer.name
        cell.detailTextLabel?.text = offer.description
    }
    
    func configure(_ cell: UITableViewCell, with element: Codable) {
        if let category = element as? YMLCategory {
            configure(cell, with: category)
        } else if let offer = element as? YMLOffer {
            configure(cell, with: offer)
        }
    }
}
