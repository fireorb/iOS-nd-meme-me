//
//  MemeCollectionViewCell.swift
//  meme_me
//
//  Created by Mihir Thanekar on 7/7/17.
//  Copyright © 2017 Mihir Thanekar. All rights reserved.
//

import UIKit

class MemeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var savedMemedImage: UIImageView!
    @IBOutlet weak var topText: UILabel!
    @IBOutlet weak var bottomText: UILabel!
    
    func setupCellWithMeme(_ meme: Meme) {
        self.savedMemedImage.image = meme.originalImage
        self.bottomText.text = meme.bottomText
        self.topText.text = meme.topText

    }
}
