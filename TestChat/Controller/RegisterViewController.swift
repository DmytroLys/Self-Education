//
//  RegisterViewController.swift
//  TestChat
//
//  Created by Dmytro on 05.01.2022.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    
    @IBAction func registerPressed(_ sender: UIButton) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error {
                print("\(e.localizedDescription)")
            } else {
                self.performSegue(withIdentifier: Constants.registerSegue, sender: self)
            }
        }
        
    }
    

    

}
