//
//  PickerViewController.swift
//  meme_me
//
//  Created by Mihir Thanekar on 7/8/17.
//  Copyright © 2017 Mihir Thanekar. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    @IBOutlet weak var picker: UIPickerView!
    
    // NSArrays are passed by reference according to https://stackoverflow.com/questions/24250938/swift-pass-array-by-reference
    var fontFamilies = [String]()
    var fontSizes = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fontFamilies = UIFont.familyNames
        fontFamilies.append("HelveticaNeue-CondensedBlack") // Add our custom font to the list
        fontFamilies = fontFamilies.sorted()
        
        for x in 12 ... 50 {
            if x % 2 == 0 { // even
                fontSizes.append("\(x)")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let fontFamilyIndexToBeSelected = fontFamilies.index(of: MemeTextSettings.fontFamilyName) {
            picker.selectRow(fontFamilyIndexToBeSelected, inComponent: 0, animated: false)
        }
        if let fontSizeIndexToBeSelected = fontSizes.index(of: "\(MemeTextSettings.fontSize)") {
            picker.selectRow(fontSizeIndexToBeSelected, inComponent: 1, animated: false)
        }
        
        
        
    }
    
    private func whichComponent(_ component: Int) -> [String] {
        switch component {
        case 0:
            return fontFamilies
        case 1:
            return fontSizes
        default:
            return Array()
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return whichComponent(component).count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == 0 { // font families
            MemeTextSettings.fontFamilyName = fontFamilies[row]
            print(MemeTextSettings.fontFamilyName)
        }
        else if component == 1 {
            if let fonttSizze = Int(fontSizes[row]) {
                MemeTextSettings.fontSize = fonttSizze
                print(MemeTextSettings.fontSize)
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return whichComponent(component)[row]
    }
    
}
