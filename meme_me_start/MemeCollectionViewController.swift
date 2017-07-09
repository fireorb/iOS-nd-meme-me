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
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailVC.image = appDelegate.memes[indexPath.row].memedImage    // Set memed image in instantiated vc
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Collection View Spacing and cell size
        let space: CGFloat = 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        
        let numberOfColumns: CGFloat = 3.0
        let width = (self.view.frame.size.width - (2 * space))/numberOfColumns
        let height = (self.view.frame.size.height - (2 * space))/5.0
        flowLayout.itemSize = CGSize(width: width, height: height)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if appDelegate.memes.count != 0 {   // Reload data only if there is any
            collectionView?.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MemeCollectionViewCell", for: indexPath) as? MemeCollectionViewCell else {
            print("Cell cast failure")
            return UICollectionViewCell()
        }
        cell.setupCellWithMeme(appDelegate.memes[indexPath.row])
        return cell
    }
}
