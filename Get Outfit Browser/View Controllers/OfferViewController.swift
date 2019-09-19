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
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    @IBOutlet var vendorCodeLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var salesNotesLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!

    var offer: YMLOffer?
}

// MARK: - UI
extension OfferViewController {
    func updateUI() {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.text = offer?.title
        navigationItem.titleView = label
        
        if let imageURL = offer?.pictures.first {
            imageView?.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "icons8-jumper"))
        }
        
        if let category = offer?.categoryId {
            categoryLabel.text = "Category: \(category)"
        } else {
            categoryLabel.isHidden = true
        }
        
        if let id = offer?.id {
            idLabel.text = "id: \(id)"
        } else {
            idLabel.isHidden = true
        }
        
        if let vendorCode = offer?.vendorCode {
            vendorCodeLabel.text = "Vendor Code: \(vendorCode)"
        } else {
            vendorCodeLabel.isHidden = true
        }
        
        if let description = offer?.description {
            descriptionLabel.text = description
        } else {
            descriptionLabel.isHidden = true
        }
        
        if let salesNotes = offer?.sales_notes {
            salesNotesLabel.text = salesNotes
        } else {
            salesNotesLabel.isHidden = true
        }

        if let price = offer?.price {
            priceLabel.text = "\(price) ₽"
        } else {
            priceLabel.isHidden = true
        }
    }
    
}

// MARK: - UIViewController
extension OfferViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
}

// MARK: - Actions
extension OfferViewController {
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        print(#line, #function)
        guard let url = offer?.url else { return }
        print(#line, #function, url)
        
        UIApplication.shared.open(url)
    }
}
