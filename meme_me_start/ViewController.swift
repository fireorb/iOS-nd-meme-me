//
//  ViewController.swift
//  meme_me_start
//
//  Created by Mihir Thanekar on 6/22/17.
//  Copyright © 2017 Mihir Thanekar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    
    let memeTextAttributes:[String:Any] = [
        NSStrokeColorAttributeName: UIColor.black,  // Border stroke
        NSForegroundColorAttributeName: UIColor.white,  // Inside color
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,   // Font style
        NSStrokeWidthAttributeName: 2.0]    // stroke width

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera) // If camera is available, the button is
        shareButton.isEnabled = imageView.image != nil ? true: false    // If there's an image
        self.subscribeToKeyboardNotifications() // Tell us when keyboard shows
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()  // Stop watching keyboard
    }
    
    
    let memeDelegate = MemeTextObject()
    override func viewDidLoad() {
        topTextField.delegate = memeDelegate
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.textAlignment = .center
        
        bottomTextField.delegate = memeDelegate
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.textAlignment = .center
    }
    @IBAction func cancelButton(_ sender: Any) {
        imageView.image = UIImage()
        shareButton.isEnabled = false
        
    }
    @IBAction func shareImage(_ sender: Any) {
        if imageView.image != nil {
            let MemeObject = Meme(topText: self.topTextField.text!, bottomText: self.bottomTextField.text!, originalImage: self.imageView.image!, view: self.view)
            let memedImage = MemeObject.makeMemedImage()
            let activityView = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
            self.present(activityView, animated: true, completion: nil)
        }
    }
    
    @IBAction func pickImage(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func pickImageFromCamera(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .camera
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func keyboardWillShow(_ notification: Notification) {
        view.frame.origin.y = 0 - getKeyboardHeight(notification)
    }
    func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification:Notification) -> CGFloat {
        
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }

}

