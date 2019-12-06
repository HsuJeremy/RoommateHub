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
    @IBOutlet weak var errorLabel: UILabel!
    
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
                self!.roomIdentifier = house.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: " ")[0].lowercased() + roomNumber.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: " ")[0].lowercased()
                
                // Verify that roomIdentifier exists in database
                let ref = Database.database().reference()
                ref.observeSingleEvent(of: .value, with: { (snapshot) in
                    let value = snapshot.value as? NSDictionary
                    let keys = value!.allKeys
                    
                    // Line to cast NSArray to Array by Patrick from StackOverflow
                    let roomsArray: [String] = keys.compactMap({ $0 as? String })
                    
                    guard let room = self!.roomIdentifier else { return }
                    
                    // Allow segue only if the roomIdentifier is contained in the database
                    if roomsArray.contains(room) {
                        self?.userSignedIn = true
                        print("Signed in")
                    } else {
                        print("Incorrect room")
                        self?.errorLabel.text = "Incorrect room"
                    }
                }) { (error) in
                    print(error.localizedDescription)
                }
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
    
    var something: String? = nil
}
