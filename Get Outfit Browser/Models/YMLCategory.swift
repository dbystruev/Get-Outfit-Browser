//
//  YMLCategory.swift
//  Get Outfit Browser
//
//  Created by Denis Bystruev on 18/09/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//
//  See https://yandex.ru/support/partnermarket/elements/categories.html

struct YMLCategory {
    let id: Int
    let name: String
    let parentId: Int?
    
    var getParentId: String {
        guard let parentId = parentId else {
            return "none"
        }
        
        return "\(parentId)"
    }
}

extension YMLCategory: Named {
    var getId: String {
        return "\(id)"
    }
}
