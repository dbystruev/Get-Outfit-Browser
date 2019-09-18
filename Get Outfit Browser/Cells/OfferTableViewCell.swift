//
//  OfferTableViewCell.swift
//  Get Outfit Browser
//
//  Created by Denis Bystruev on 19/09/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import UIKit

class OfferTableViewCell: UITableViewCell {
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView?.bounds = CGRect(x: 0, y: 0, width: 75, height: 75)
    }
}
