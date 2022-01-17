//
//  LoginViewController.swift
//  TestChat
//
//  Created by Dmytro on 05.01.2022.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    
    @IBAction func loginPressed(_ sender: Any) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
          
            if let e = error {
                print(e.localizedDescription)
            } else {
                self.performSegue(withIdentifier: Constants.loginSegue, sender: self)
            }
          
        }
        
    }
    
}
