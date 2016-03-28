//
//  ViewController.swift
//  StoneCalc
//
//  Created by James on 3/27/16.
//  Copyright © 2016 James. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    // 3000lbs crusher run with 0.20 loss
    // 2500lbs with 0 loss is #1A Shelby (Possibly Mason Sand too)
    // 2600lbs with 0 loss is #1 Shelby  (Possibly Pea Gravel an sand filter sand too)
    // 2700lbs with 0 loss is #2 Shelby and (#3 & #4 mixed)
    // 3000lbs with 0 loss is Shot Rock at Shelby
    // 2200 lbs for topsoil at Shelby
    
    var theMaterials = ["Crusher Run", "1A", "Mason Sand", "1", "Pea Gravel", "2", "3 & 4", "Shot Rock",
                        "Topsoil"]
    
    var materialWeight = ["Crusher Run" : 3000, "1A" : 2500, "Mason Sand" : 2500, "1" : 2600,
                          "Pea Gravel" : 2600,  "2" : 2700, "3 & 4": 2700, "Shot Rock" : 3000,
                          "Topsoil" : 2200]
    
    var materialLoss = ["Crusher Run" : 0.20, "1A" : 0.0, "Mason Sand" : 0.0, "1" : 0.0,
                        "Pea Gravel" : 0.0,  "2" : 0.0, "3 & 4": 0.0, "Shot Rock" : 0.0,
                        "Topsoil" : 0.0]
    
    var selectedMaterial = "Crusher Run"
    
    @IBOutlet weak var length: UITextField!
    @IBOutlet weak var width: UITextField!
    @IBOutlet weak var depth: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var materialPicker: UIPickerView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        materialPicker.dataSource = self
        materialPicker.delegate = self
        length.delegate = self
        width.delegate = self
        depth.delegate = self
    }

   // Data Source
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return theMaterials.count
        
    }
    
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return theMaterials[row]
        
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMaterial = theMaterials[row]
    }
    
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    

    @IBAction func calculatePressed(sender: UIButton) {
        
        self.view.endEditing(true)
        
        let theLength = (length.text! as NSString).floatValue
        let theWidth = (width.text! as NSString).floatValue
        let theDepth = (depth.text! as NSString).floatValue

        let cubicYards = (theLength * theWidth * (theDepth / 12)) / 27
        
        
        // 3000lbs crusher run with 0.20 loss
        // 2500lbs with 0 loss is #1A Shelby (Possibly Mason Sand too)
        // 2600lbs with 0 loss is #1 Shelby  (Possibly Pea Gravel an sand filter sand too)
        // 2700lbs with 0 loss is #2 Shelby and (#3 & #4 mixed)
        // 3000lbs with 0 loss is Shot Rock at Shelby
        // 2200 lbs for topsoil at Shelby
        
        let theWeight = materialWeight[selectedMaterial]
        
        var weightInPounds = cubicYards * 3000
        
        if theWeight != nil
        {
            weightInPounds = cubicYards * Float(theWeight!)
        }
        
        let weightInTons = weightInPounds / 2000
        
        let theLoss = materialLoss[selectedMaterial]
        
        var loss = weightInTons * 0.20
        
        if theLoss != nil
        {
            loss = weightInTons * Float(theLoss!)
        }

        let weight = weightInTons + loss
        
        resultLabel.text = "\(weight)"
        
        
    }

}

