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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.textField.delegate = self
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
    
    @IBAction func textFieldEditingCompleted(_ sender: Any) {
    }
    
}
