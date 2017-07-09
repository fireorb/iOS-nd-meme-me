//
//  MemeViewController.swift
//  meme_me_start
//
//  Created by Mihir Thanekar on 6/22/17.
//  Copyright © 2017 Mihir Thanekar. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController {
    // I used a settings icon from flaticon as shown below: 
    //<div>Icons made by <a href="http://www.flaticon.com/authors/bogdan-rosu" title="Bogdan Rosu">Bogdan Rosu</a> from <a href="http://www.flaticon.com" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>
    //E.g.: Icon made by Bogdan Rosu from www.flaticon.com
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var TopToolbar: UINavigationItem!
    @IBOutlet weak var BottomToolbar: UIToolbar!
    
    var memeTextAttributes: [String: Any] = [
        NSStrokeColorAttributeName: UIColor.black,  // Border stroke
        NSForegroundColorAttributeName: UIColor.white,  // Inside color
        NSFontAttributeName: UIFont(name: MemeTextSettings.fontFamilyName, size: CGFloat(MemeTextSettings.fontSize))!,   // Font style
        NSStrokeWidthAttributeName: -3]
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera) // If camera is available, the button is
        shareButton.isEnabled = imageView.image != nil ? true: false    // If there's an image
        self.subscribeToKeyboardNotifications() // Tell us when keyboard shows
        
        print("Updated text attributes")
        memeTextAttributes[NSFontAttributeName] = UIFont(name: MemeTextSettings.fontFamilyName, size: CGFloat(MemeTextSettings.fontSize))!
        
        setTextProperties(topTextField)
        setTextProperties(bottomTextField)

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()  // Stop watching keyboard
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    let memeDelegate = MemeTextObject()
    
    func setTextProperties(_ textfield: UITextField) {
        textfield.delegate = memeDelegate
        textfield.defaultTextAttributes = memeTextAttributes
        textfield.textAlignment = .center
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareImage(_ sender: Any) {
        if imageView.image != nil {
            var hiddenViews = [UIView]()
            if let navBar = self.navigationController?.navigationBar {
                hiddenViews.append(navBar)  // UINavigationBar is a subclass of UIView
            }
            hiddenViews.append(BottomToolbar)
            
            let memedImage = Meme.makeMemedImage(view: self.view, viewsToHide: hiddenViews)
            let activityView = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
            activityView.completionWithItemsHandler = { activity, success, items, error in
                if success {
                    let MemeObject = Meme(topText: self.topTextField.text!, bottomText: self.bottomTextField.text!, originalImage: self.imageView.image!, memedImage: memedImage)   // Make a memed object
                   
                    let appDelegate = UIApplication.shared.delegate as! AppDelegate // Save to appDelegate
                    appDelegate.memes.append(MemeObject)
                    self.dismiss(animated: true, completion: nil)   // Go back to sent memes
                }
            }
            self.present(activityView, animated: true, completion: nil)
        }
    }
    
    @IBAction func pickImageFromCamera(_ sender: UIBarButtonItem) {
        // If tag is 2, source type is photo library
        sender.tag == 2 ? pickImage(.photoLibrary) : pickImage(.camera)
    }
    
    func pickImage(_ sourceType: UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isEditing {  // Only shift view if bottom text field is being edited.
            view.frame.origin.y = 0 - getKeyboardHeight(notification)
        }
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

