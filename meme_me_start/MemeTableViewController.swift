//
//  MemeTableViewController.swift
//  meme_me
//
//  Created by Mihir Thanekar on 7/7/17.
//  Copyright © 2017 Mihir Thanekar. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "MemeDetailViewController") as! MemeDetailViewController
        detailVC.image = appDelegate.memes[indexPath.row].memedImage
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if appDelegate.memes.count != 0 {   // Why reload if there's nothing to reload?
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appDelegate.memes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MemeTableViewCell")
        
        let memesArray = appDelegate.memes
        cell?.imageView?.image = memesArray[indexPath.row].memedImage
        cell?.textLabel?.text = "\(memesArray[indexPath.row].topText)...\(memesArray[indexPath.row].bottomText)"    // Truncate text to show top and bottom
        
        return cell ?? UITableViewCell()
    }
}
