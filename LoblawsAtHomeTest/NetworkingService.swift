//
//  NetworkingService.swift
//  LoblawsAtHomeTest
//
//  Created by Reiss Zurbyk on 2019-08-01.
//  Copyright © 2019 Reiss Zurbyk. All rights reserved.
//

import Foundation

class NetworkingService {
    
    static let shared = NetworkingService()
    private init() {}
    
    let session = URLSession.shared

    func getReddits(success successBlock: @escaping (Model) -> Void) {
        guard let url = URL(string: "https://www.reddit.com/r/swift/.json?raw_json=1") else { return }
        let request = URLRequest(url: url)
        
        session.dataTask(with: request) { [weak self] data, _, error in
             guard let `self` = self else { return }
            
            if let error = error { print(error); return }
            do {
                let decoder = JSONDecoder()
                //decoder.keyDecodingStrategy = .convertFromSnakeCase
                let model = try decoder.decode(Model.self, from: data!)
                successBlock(model)
                print("model is \(model)")
                
            } catch {
                print(error)
            }
            }.resume()
    }
}
