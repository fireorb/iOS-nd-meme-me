//
//  Meme Maker.swift
//  meme_me
//
//  Created by Mihir Thanekar on 6/23/17.
//  Copyright © 2017 Mihir Thanekar. All rights reserved.
//

import UIKit

struct Meme {
    let topText: String
    let bottomText: String
    let originalImage: UIImage
    let memedImage: UIImage
    
    static func makeMemedImage(view: UIView, viewsToHide: [UIView]) -> UIImage {
        for view in viewsToHide {
            view.alpha = 0  // Hide toolbars
        }
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0)   // Start taking screen- size bitmap with given size
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)    // Draw out the view
        let memedImage = UIGraphicsGetImageFromCurrentImageContext()    // Get the bitmap
        UIGraphicsEndImageContext()
        for view in viewsToHide {
            view.alpha = 1  // Show toolbars
        }
        return memedImage != nil ? memedImage! : UIImage()  // If there's something, return it
    }
}
