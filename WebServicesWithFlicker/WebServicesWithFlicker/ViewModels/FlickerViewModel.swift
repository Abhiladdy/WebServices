//
//  FlickerViewModel.swift
//  WebServicesWithFlicker
//
//  Created by Abhilash Reddy Jain on 11/16/18.
//  Copyright © 2018 Abhilash Reddy. All rights reserved.
//

import Foundation
import RealmSwift

fileprivate enum urlQueryValue: String {
    case dogsList = "dogs"
    case treeList = "trees"
    case catsList = "cats"
}

class FlickerViewModel: NSObject {
    lazy var apiUrlString: String = { return "https://api.flickr.com/services/feeds/photos_public.gne?format=json&tags=\(urlQueryValue.catsList.rawValue)&nojsoncallback=1#" }()
    fileprivate let realm = try? Realm()
    var photoDetails: Results<PhotosRealmModel>? = nil
    
    private func getDataFromServer(completion: @escaping (_ data: PhotosListModel?, _ error: Error?) -> Void ) {
        let urlString = apiUrlString
        guard let url = URL(string: urlString) else {
            return completion(nil, "Url issue" as? Error)
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, error == nil {
                do {
                    if let json = try? JSONDecoder().decode(PhotosListModel.self, from: data) {
                        DispatchQueue.main.async {
                            completion(json, nil)
                        }
                    } else {
                        completion(nil, error?.localizedDescription as? Error)
                    }
                }
            } else {
                completion(nil, error?.localizedDescription as? Error)
            }
            }.resume()
    }
    
    func retrivedData(_ indexPath: IndexPath) {
        getDataFromServer { (response, error) in
            if error == nil {
                let photoDetails = PhotosRealmModel()
                photoDetails.imageTitle = response?.items?[indexPath.row].title
                photoDetails.imageUrl = response?.items?[indexPath.row].media?.m
                photoDetails.imageDate = response?.items?[indexPath.row].date_taken
                photoDetails.imageDescription = response?.items?[indexPath.row].description
                self.saveDataToRealm(photoDetails)
            } else {
                debugPrint(error ?? "Empty Error")
            }
        }
    }
    
    private func saveDataToRealm(_ realmObject: Object) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(realmObject)
            }
        } catch {
            debugPrint("Writing Error \(error)")
        }
    }
    
    func fetchDataFromRealm() {
        guard let realmObj = realm else {return}
        photoDetails = realmObj.objects(PhotosRealmModel.self)
    }
    
}
