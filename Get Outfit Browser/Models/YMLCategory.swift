//
//  YMLCategory.swift
//  Get Outfit Browser
//
//  Created by Denis Bystruev on 18/09/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

struct YMLCategory {
    let id: Int
    let name: String
    let parentId: Int?
}

extension YMLCategory: Named {
    var getId: String {
        return "\(id)"
    }
}
