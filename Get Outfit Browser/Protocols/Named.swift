//
//  Named.swift
//  Get Outfit Browser
//
//  Created by Denis Bystruev on 18/09/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

protocol Named: Codable {
    var name: String { get }
    var getId: String { get }
}
