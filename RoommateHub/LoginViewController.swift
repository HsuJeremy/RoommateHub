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
import FirebaseDatabase

class LoginViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var house: UITextField!
    @IBOutlet weak var roomNumber: UITextField!
    
    var userSignedIn: Bool = false
    var roomIdentifier: String? = nil
    
    @IBAction func loginAction(_ sender: Any) {
        guard let email = email.text else { return }
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: " ")[0]
        guard let password = password.text else { return }
        guard let house = house.text else { return }
        guard let roomNumber = roomNumber.text else { return }
        
        // From official Firebase documentation
        Auth.auth().signIn(withEmail: trimmedEmail, password: password) { [weak self] authResult, error in
            guard let strongSelf = self else { return }
            if error == nil && authResult != nil {
                self!.roomIdentifier = house.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: " ")[0] + roomNumber.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: " ")[0]
                
                // Allow segue
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginToHome", let destination = segue.destination as? HomeViewController {
            destination.roomIdentifier = roomIdentifier!
        }
    }
}
