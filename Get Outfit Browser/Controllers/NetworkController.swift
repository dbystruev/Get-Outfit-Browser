//
//  NetworkController.swift
//  Get Outfit Browser
//
//  Created by Denis Bystruev on 18/09/2019.
//  Copyright © 2019 Denis Bystruev. All rights reserved.
//

import Foundation

class NetworkController<T: Codable> {
    private let url: URL
    
    init?(_ path: String) {
        guard let url = URL(string: path) else { return nil }
        self.url = url
    }
    
    func getMany(_ parameters: [String: String?] = [:], completion: @escaping ([T]?, Error?) -> Void) {
        get(parameters, completion: completion)
    }
    
    func getOne(_ parameters: [String: String?] = [:], completion: @escaping (T?, Error?) -> Void) {
        get(parameters, completion: completion)
    }
    
    func get<U: Codable>(_ parameters: [String: String?] = [:], completion: @escaping (U?, Error?) -> Void) {
        let requestURL = url.withQueries(parameters) ?? url
        
        #if DEBUG
        print(#line, #function, requestURL)
        #endif
        
        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            guard let data = data else {
                completion(nil, error)
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(U.self, from: data)
                completion(decodedData, nil)
            }  catch let decodeError {
                completion(nil, decodeError)
            }
        }
        
        task.resume()
    }
    
    
}
