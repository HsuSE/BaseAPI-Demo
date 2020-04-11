//
//  Photo.swift
//  BaseAPI-Demo
//
//  Created by SE Hsu on 2020/4/12.
//  Copyright © 2020 HsuSE. All rights reserved.
//

import Foundation

struct ImageDetail: Codable, Identifiable, Hashable {
    let albumId: Int
    let id: Int
    let title: String
    let thumbnailUrl: URL
    let url: URL
}
