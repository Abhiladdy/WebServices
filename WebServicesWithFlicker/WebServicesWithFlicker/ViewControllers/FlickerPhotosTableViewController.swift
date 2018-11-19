//
//  FlickerPhotosTableViewController.swift
//  WebServicesWithFlicker
//
//  Created by Abhilash Reddy Jain on 11/16/18.
//  Copyright © 2018 Abhilash Reddy. All rights reserved.
//

import UIKit

class FlickerPhotosTableViewController: UITableViewController {
    let flickerViewModel = FlickerViewModel()
    lazy var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpActivityIndicator()
        tableView.estimatedRowHeight = 500
        flickerViewModel.fetchDataFromRealm()
        tableView.reloadData()
    }
    
    private func setUpActivityIndicator() {
        activityIndicator.color = UIColor.black
        activityIndicator.style = .gray
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(flickerViewModel.photoDetails?.count)
        return flickerViewModel.photoDetails?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoDetailsCell", for: indexPath) as? PhotoDetailsTableViewCell else { return UITableViewCell() }
        
        flickerViewModel.retrivedData(indexPath)
        cell.imageTitle.text = flickerViewModel.photoDetails?[indexPath.row].imageTitle
        cell.imageDate.text = flickerViewModel.photoDetails?[indexPath.row].imageDate
        cell.imageDesc.text = flickerViewModel.photoDetails?[indexPath.row].imageDescription
        
        self.activityIndicator.startAnimating()
        cell.imageView?.image = UIImage(url: URL(string: self.flickerViewModel.photoDetails?[indexPath.row].imageUrl ?? ""))
        self.activityIndicator.stopAnimating()
        
        return cell
    }
}


extension UIImage {
    convenience init?(url: URL?) {
        guard let url = url else { return nil }
        
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data)
        } catch {
            print("Cannot load image from url: \(url) with error: \(error)")
            return nil
        }
    }
}
