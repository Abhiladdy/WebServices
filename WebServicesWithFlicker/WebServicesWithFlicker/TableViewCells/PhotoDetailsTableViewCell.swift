//
//  PhotoDetailsTableViewCell.swift
//  WebServicesWithFlicker
//
//  Created by Abhilash Reddy Jain on 11/17/18.
//  Copyright © 2018 Abhilash Reddy. All rights reserved.
//

import UIKit

class PhotoDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var imageTitle: UILabel!
    @IBOutlet weak var imageDate: UILabel!
    @IBOutlet weak var imageDesc: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
