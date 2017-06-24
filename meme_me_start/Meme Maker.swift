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
    view: UIView
    
    init(topText: String, bottomText: String, originalImage: UIImage, view: UIView) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.view = view
    }
    
    func makeMemedImage() -> UIImage {
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawHierarchy(in: self.view.frame , afterScreenUpdates: true)
        let memedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return memedImage != nil ? memedImage! : UIImage()
    }
}
