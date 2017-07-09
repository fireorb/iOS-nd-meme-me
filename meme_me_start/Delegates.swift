//
//  Delegates.swift
//  meme_me_start
//
//  Created by Mihir Thanekar on 6/22/17.
//  Copyright © 2017 Mihir Thanekar. All rights reserved.
//

import Foundation
import UIKit

extension MemeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {   // Provide edited image
            imageView.image = image
        }
        print("Image picked!")
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("Image picking cancelled!")
        picker.dismiss(animated: true, completion: nil)
    }
}

/// Class that lets our text fields behave properly
class MemeTextObject: NSObject, UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == "BOTTOM" || textField.text == "TOP" {
            textField.text = ""
        }
    }

}
