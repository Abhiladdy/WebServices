//
//  PhotosModel.swift
//  WebServicesWithFlicker
//
//  Created by Abhilash Reddy Jain on 11/16/18.
//  Copyright © 2018 Abhilash Reddy. All rights reserved.
//

import Foundation

struct PhotosListModel: Decodable {
    let items: [PhotosDetailsModel]?
}

struct PhotosDetailsModel: Decodable {
    let title: String?
    let media: PhotoModel?
    let date_taken: String?
    let description: String?
}

struct PhotoModel: Decodable {
    let m: String?
}


