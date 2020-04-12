//
//  ImageLoader.swift
//  BaseAPI-Demo
//
//  Created by SE Hsu on 2020/4/12.
//  Copyright © 2020 HsuSE. All rights reserved.
//

import Foundation

class ImageLoader {
    static func load(url: URL?, completion: @escaping (Data) -> ()) {
        if let url = url {
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                guard let data = data else { return }
                DispatchQueue.main.async {
                    completion(data)
                }
                
            }.resume()
        }
    }
}
