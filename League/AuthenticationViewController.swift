//
//  ViewController.swift
//  TouchIDTutorial
//
//  Created by Frederik Jacques on 30/09/15.
//  Copyright © 2015 Frederik Jacques. All rights reserved.
//

import UIKit
import LocalAuthentication

class AuthenticationViewController: UIViewController {

    /**
        This method gets called when the users clicks on the
        login button in the user interface.
    
        - parameter sender: a reference to the button that has been touched
    */
    @IBAction func loginButtonClicked(_ sender: UIButton) {
        
        // 1. Create a authentication context
        let authenticationContext = LAContext()
        var error:NSError?
        
        // 2. Check if the device has a fingerprint sensor
        // If not, show the user an alert view and bail out!
        guard authenticationContext.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            
            showAlertViewIfNoBiometricSensorHasBeenDetected()
            return
            
        }
        
        // 3. Check the fingerprint
        authenticationContext.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "Security Check",
            reply: { [unowned self] (success, error) -> Void in
                
            if( success ) {
                
                // Fingerprint recognized
                // Go to view controller
                self.navigateToAuthenticatedViewController()
                
            }else {
                
                // Check if there is an error
                if let error = error {
                    
                    let message = self.errorMessageForLAErrorCode(error._code)
                    self.showAlertViewAfterEvaluatingPolicyWithMessage(message)
                    
                }
            }
        })
    }
    
    /**
        This method will present an UIAlertViewController to inform the user that the device has not a TouchID sensor.
    */
    func showAlertViewIfNoBiometricSensorHasBeenDetected(){
        
        showAlertWithTitle("Error", message: "This device does not have a TouchID sensor.")
        
    }
    
    /**
        This method will present an UIAlertViewController to inform the user that there was a problem with the TouchID sensor.
    
        - parameter error: the error message
    
    */
    func showAlertViewAfterEvaluatingPolicyWithMessage( _ message:String ){
        
        showAlertWithTitle("Error", message: message)
        
    }

    /**
        This method presents an UIAlertViewController to the user.
        
        - parameter title:  The title for the UIAlertViewController.
        - parameter message:The message for the UIAlertViewController.
    
    */
    func showAlertWithTitle( _ title:String, message:String ) {
     
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertVC.addAction(okAction)
        
        DispatchQueue.main.async { () -> Void in
        
            self.present(alertVC, animated: true, completion: nil)
            
        }
        
    }
    
    /**
    This method will return an error message string for the provided error code.
    The method check the error code against all cases described in the `LAError` enum.
    If the error code can't be found, a default message is returned.
    
    - parameter errorCode: the error code
    - returns: the error message
    */
func errorMessageForLAErrorCode( _ errorCode:Int ) -> String {
    
    var message = ""
    
    switch errorCode {
        
    case LAError.Code.appCancel.rawValue:
        message = "Authentication was cancelled by application"
        
    case LAError.Code.authenticationFailed.rawValue:
        message = "The user failed to provide valid credentials"
        
    case LAError.Code.invalidContext.rawValue:
        message = "The context is invalid"
        
    case LAError.Code.passcodeNotSet.rawValue:
        message = "Passcode is not set on the device"
        
    case LAError.Code.systemCancel.rawValue:
        message = "Authentication was cancelled by the system"
        
    case LAError.Code.touchIDLockout.rawValue:
        message = "Too many failed attempts."
        
    case LAError.Code.touchIDNotAvailable.rawValue:
        message = "TouchID is not available on the device"
        
    case LAError.Code.userCancel.rawValue:
        message = "The user did cancel"
        
    case LAError.Code.userFallback.rawValue:
        message = "The user chose to use the fallback"
        
    default:
        message = "Did not find error code on LAError object"
        
    }
    
    return message
    
}
    
    /**
        This method will push the authenticated view controller onto the UINavigationController stack
    */
    func navigateToAuthenticatedViewController(){
        
        DispatchQueue.main.async { () -> Void in
            
            self.performSegue(withIdentifier: "LoggedInViewController", sender: nil)
        }
//        self.performSegue(withIdentifier: "LoggedInViewController", sender: nil)
        
//        if let loggedInVC = storyboard?.instantiateViewController(withIdentifier: "LoggedInViewController") {
//            
//            DispatchQueue.main.async { () -> Void in
//                
//                self.navigationController?.pushViewController(loggedInVC, animated: true)
//            }
//            
//        }
        
    }

}

