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
        UIGraphicsBeginImageContextWithOptions(view.frame.size, false, 0)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let memedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return memedImage != nil ? memedImage! : UIImage()
    }
}
