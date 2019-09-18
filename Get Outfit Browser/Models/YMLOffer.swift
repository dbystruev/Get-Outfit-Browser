//
//  YMLOffer.swift
//  Get Outfit Browser
//
//  Created by Denis Bystruev on 18/09/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import Foundation

struct YMLOffer {
    let id: String
    let categoryId: Int
    let description: String
    let model: String
    let modified_time: TimeInterval // since 1970.01.01
    let name: String
    let oldprice: Decimal
    let pictures = [URL]()
    let price: Decimal
    let sales_notes: String
    let typePrefix: String
    let url: URL
    let vendor: String
    let vendorCode: String
}

extension YMLOffer: Named {
    var getId: String {
        return id
    }
}
