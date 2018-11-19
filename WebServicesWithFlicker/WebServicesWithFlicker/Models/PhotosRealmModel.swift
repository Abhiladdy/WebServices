//
//  PhotosRealmModel.swift
//  WebServicesWithFlicker
//
//  Created by Abhilash Reddy Jain on 11/17/18.
//  Copyright © 2018 Abhilash Reddy. All rights reserved.
//

import Foundation
import RealmSwift

class PhotosRealmModel: Object {
    @objc dynamic var imageUrl: String?
    @objc dynamic var imageTitle: String?
    @objc dynamic var imageDate: String?
    @objc dynamic var imageDescription: String?
}
