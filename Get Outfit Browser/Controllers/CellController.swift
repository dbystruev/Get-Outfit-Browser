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
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = category.name
        cell.detailTextLabel?.text = "id: \(category.id)"
    }
    
    func configure(_ cell: UITableViewCell, with offer: YMLOffer) {
        let prefix = offer.typePrefix?.appending(" ") ?? ""
        cell.textLabel?.text = "\(prefix)\(offer.vendor) \(offer.model)"
        cell.detailTextLabel?.text = "\(offer.price) ₽"
    }
    
    func configure(_ cell: UITableViewCell, with element: Codable) {
        if let category = element as? YMLCategory {
            configure(cell, with: category)
        } else if let offer = element as? YMLOffer {
            configure(cell, with: offer)
        }
    }
}
