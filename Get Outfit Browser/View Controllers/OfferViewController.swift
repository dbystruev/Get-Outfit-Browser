//
//  OfferViewController.swift
//  Get Outfit Browser
//
//  Created by Denis Bystruev on 19/09/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import SDWebImage
import UIKit

class OfferViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    
    var offer: YMLOffer?
}

// MARK: - UIViewController
extension OfferViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.text = offer?.title
        navigationItem.titleView = label
        
        if let imageURL = offer?.pictures.first {
            imageView?.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "icons8-jumper"))
        }
    }
}
