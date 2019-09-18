//
//  URL+Extension.swift
//  Get Outfit Browser
//
//  Created by Denis Bystruev on 18/09/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import Foundation

extension URL {
    func withQueries(_ queries: [String: String?]) -> URL? {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: true) else { return nil }
        var queryItems = components.queryItems ?? []
        queryItems += queries.map { URLQueryItem(name: $0.key, value: $0.value ?? "nil") }
        components.queryItems = queryItems
        return components.url
    }
}
