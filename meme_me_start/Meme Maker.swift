//
//  Meme Maker.swift
//  meme_me
//
//  Created by Mihir Thanekar on 6/23/17.
//  Copyright © 2017 Mihir Thanekar. All rights reserved.
//

import UIKit

struct Meme {
    let topText: String,
    bottomText: String,
    originalImage: UIImage,
    memedImage: UIImage
    
    init(topText: String, bottomText: String, originalImage: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
    
    static func makeMemedImage(view: UIView) -> UIImage {
        // TODO: Make sure image doesn't have toolbars.. 
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0)   // Start taking screen- size bitmap with given size
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)    // Draw out the view
        let memedImage = UIGraphicsGetImageFromCurrentImageContext()    // Get the bitmap
        UIGraphicsEndImageContext()
        
        return memedImage != nil ? memedImage! : UIImage()  // If there's something, return it
    }
}
