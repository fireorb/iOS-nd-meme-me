//
//  MemeDetailViewController.swift
//  meme_me
//
//  Created by Mihir Thanekar on 7/7/17.
//  Copyright © 2017 Mihir Thanekar. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    @IBOutlet weak var memeDetailImage: UIImageView!
   
    var image: UIImage? = nil
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if image != nil {
            memeDetailImage.image = image
        }
    }
    
}
