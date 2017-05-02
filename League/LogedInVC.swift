//
//  LogedInVC.swift
//  League
//
//  Created by Andrew Foster on 5/2/17.
//  Copyright © 2017 Andrii Halabuda. All rights reserved.
//

import UIKit

class LogedInVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: CustomTextField!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var valueLbl: UILabel!
    @IBOutlet weak var currentLeague: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.textField.delegate = self
        valueLbl.text = "$ \(defaults.integer(forKey: "globalValue"))"
        setViewColor()
        print(defaults.integer(forKey: "globalValue"))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func backBtnPressed(_ sender: CustomButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func valueSet(_ sender: Any) {
        
        if textField.text == nil || textField.text == "" {
            
            textField.text = String(0)
            
        } else if Int(textField.text!)! > 999999999 {
            
            defaults.set(999999999, forKey: "globalValue")
            
        } else {
            
            defaults.set(Int(textField.text!), forKey: "globalValue")
            print(defaults.integer(forKey: "globalValue"))
            valueLbl.text = "$ \(defaults.integer(forKey: "globalValue"))"
        }
        
        setViewColor()
    }
    
    func setViewColor() {
        if defaults.integer(forKey: "globalValue") >= 1 && defaults.integer(forKey: "globalValue") < 100 {
            self.colorView.backgroundColor = .blue
            currentLeague.text = "Blue League"
            
        } else if defaults.integer(forKey: "globalValue") >= 100 && defaults.integer(forKey: "globalValue") < 1000 {
            self.colorView.backgroundColor = .green
            currentLeague.text = "Green League"
            
        } else if defaults.integer(forKey: "globalValue") >= 1000 && defaults.integer(forKey: "globalValue") < 10_000 {
            self.colorView.backgroundColor = .yellow
            currentLeague.text = "Yellow League"
            
        } else if defaults.integer(forKey: "globalValue") >= 10_000 && defaults.integer(forKey: "globalValue") < 100_000 {
            self.colorView.backgroundColor = .red
            currentLeague.text = "Red League"
            
        } else if defaults.integer(forKey: "globalValue") >= 100_000 && defaults.integer(forKey: "globalValue") < 1_000_000 {
            self.colorView.backgroundColor = .purple
            currentLeague.text = "Purple League"
            
        } else if defaults.integer(forKey: "globalValue") > 1_000_000 {
            self.colorView.backgroundColor = .darkGray
            currentLeague.text = "Ultra League"
            
        } else {
            self.colorView.backgroundColor = .white
            currentLeague.text = "Current League"
        }
    }
    
}
