//
//  MemeCollectionViewController.swift
//  meme_me
//
//  Created by Mihir Thanekar on 7/7/17.
//  Copyright © 2017 Mihir Thanekar. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class MemeCollectionViewController: UICollectionViewController {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailVC.image = appDelegate.memes[indexPath.row].memedImage
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionView?.reloadData()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as? MemeCollectionViewCell else {
            print("Cell cast failure")
            return UICollectionViewCell()
        }
        cell.savedMemedImage.image = appDelegate.memes[indexPath.row].memedImage
        
        return cell
    }
}
