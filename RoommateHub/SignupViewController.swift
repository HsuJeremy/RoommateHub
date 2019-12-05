//
//  SignupViewController.swift
//  RoommateHub
//
//  Created by Jeremy Hsu on 12/4/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class SignupViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirm: UITextField!
    
    var userCreated: Bool = false
    
    @IBAction func signUpAction(_ sender: Any) {
        guard let email = email.text else { return }
        guard let password = password.text else { return }
        
        // From official Firebase documentation
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            print(authResult)
            if error == nil && authResult != nil {
                self.userCreated = true
                print("User created")
            } else {
                print(error) 
                print("No")
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return self.userCreated
    }
}
