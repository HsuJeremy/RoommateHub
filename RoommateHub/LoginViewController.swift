//
//  LoginViewController.swift
//  RoommateHub
//
//  Created by Jeremy Hsu on 12/4/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var userSignedIn: Bool = false
    
    @IBAction func loginAction(_ sender: Any) {
        guard let email = email.text else { return }
        guard let password = password.text else { return }
        
        // From official Firebase documentation
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if error == nil && authResult != nil {
                self?.userSignedIn = true
                print("Signed in")
            } else {
                print(error)
            }
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return self.userSignedIn
    }
    
}
