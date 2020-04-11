//
//  APIRequest.swift
//  BaseAPI-Demo
//
//  Created by SE Hsu on 2020/4/12.
//  Copyright © 2020 HsuSE. All rights reserved.
//


import Foundation
import Combine

class APIRequest {
    let resourceURL: URL
    var images = [ImageDetail]() 

    
    init(endpoint: String) {
        let resourceString = "https://jsonplaceholder.typicode.com/\(endpoint)"
        guard let resourceURL = URL(string: resourceString) else { fatalError() }
        
        self.resourceURL = resourceURL
        
        fetch()
    }
    
    fileprivate func fetch() {
        var urlRequest = URLRequest(url: self.resourceURL)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200,
                let jsonData = data else { return }
            
            let decoder = JSONDecoder()
            guard let images = try? decoder.decode([ImageDetail].self, from: jsonData) else { return }
            
            DispatchQueue.main.async {
                self.images = images
            }
            print("Fetch completed.")
        }.resume()
    }
    
}
