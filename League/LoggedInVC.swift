//
//  LogedInVC.swift
//  League
//
//  Created by Andrew Foster on 5/2/17.
//  Copyright © 2017 Andrii Halabuda. All rights reserved.
//

import UIKit

class LoggedInVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: CustomTextField!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var valueLbl: UILabel!
    @IBOutlet weak var currentLeague: UILabel!
    @IBOutlet weak var colorImg: UIImageView!
    
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
        self.view.endEditing(true)
    }
    
    
    @IBAction func doneBtn(_ sender: CustomButton) {
        self.view.endEditing(true)
    }
    
    @IBAction func valueSet(_ sender: Any) {
        
        if textField.text == nil || textField.text == "" {
            
            textField.text = String(0)
            defaults.set(Int(textField.text!), forKey: "globalValue")
            valueLbl.text = "$ \(defaults.integer(forKey: "globalValue"))"
            
        } else if Int(textField.text!)! > 999999999 {
            
            defaults.set(999999999, forKey: "globalValue")
            print(defaults.integer(forKey: "globalValue"))
            valueLbl.text = "$ \(defaults.integer(forKey: "globalValue"))"
            
        } else {
            
            defaults.set(Int(textField.text!), forKey: "globalValue")
            print(defaults.integer(forKey: "globalValue"))
            valueLbl.text = "$ \(defaults.integer(forKey: "globalValue"))"
        }
        
        setViewColor()
    }
    
    func setViewColor() {
        if defaults.integer(forKey: "globalValue") >= 1 && defaults.integer(forKey: "globalValue") < 100 {
            self.colorImg.image = UIImage(named: "blue")
            currentLeague.text = "Blue League"
            
        } else if defaults.integer(forKey: "globalValue") >= 100 && defaults.integer(forKey: "globalValue") < 1000 {
            self.colorImg.image = UIImage(named: "green")
            currentLeague.text = "Green League"
            
        } else if defaults.integer(forKey: "globalValue") >= 1000 && defaults.integer(forKey: "globalValue") < 10_000 {
            self.colorImg.image = UIImage(named: "yellow")
            currentLeague.text = "Yellow League"
            
        } else if defaults.integer(forKey: "globalValue") >= 10_000 && defaults.integer(forKey: "globalValue") < 100_000 {
            self.colorImg.image = UIImage(named: "red")
            currentLeague.text = "Red League"
            
        } else if defaults.integer(forKey: "globalValue") >= 100_000 && defaults.integer(forKey: "globalValue") < 1_000_000 {
            self.colorImg.image = UIImage(named: "purple")
            currentLeague.text = "Purple League"
            
        } else if defaults.integer(forKey: "globalValue") > 1_000_000 {
            self.colorImg.image = UIImage(named: "ultra")
            currentLeague.text = "Ultra League"
            
        } else {
            self.colorImg.image = nil
            currentLeague.text = "Current League"
        }
    }
    
}
