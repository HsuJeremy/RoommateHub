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
import FirebaseDatabase

class SignupViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var hometown: UITextField!
    @IBOutlet weak var concentration: UITextField!
    @IBOutlet weak var gradYear: UITextField!
    @IBOutlet weak var house: UITextField!
    @IBOutlet weak var roomNumber: UITextField!
    @IBOutlet weak var age: UITextField!
    @IBOutlet weak var cellPhoneNumber: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirm: UITextField!
    @IBOutlet weak var signUp: UIButton!
    
    var userCreated: Bool = false
    var roomIdentifier: String? = nil
    
    @IBAction func signUpAction(_ sender: Any) {
        // Verify that all the fields are entered in
        guard let fullName = fullName.text else { return }
        let fullNameArr = fullName.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: " ")
        guard let hometown = hometown.text else { return }
        let trimmedHometown = hometown.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let concentration = concentration.text else { return }
        let trimmedConcentration = concentration.trimmingCharacters(in: .whitespacesAndNewlines)
        guard let gradYear = gradYear.text else { return }
        if Int(gradYear) == nil { return }
        guard let house = house.text else { return }
        let trimmedHouse = house.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: " ")[0]
        guard let roomNumber = roomNumber.text else { return }
        guard let age = age.text else { return }
        if Int(age) == nil { return }
        guard let cellPhoneNumber = cellPhoneNumber.text else { return }
        if Int(cellPhoneNumber) == nil { return }
        
        // Verify that the email is in proper format
        guard let email = email.text else { return }
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: " ")[0]
        
        // Verify that the password is more than 6 characters long
        guard let password = password.text else { return }
        
        // Verify that the password confirmation matches the password
        guard let passwordConfirm = passwordConfirm.text else { return }
        if password != passwordConfirm { return }

        
        // From official Firebase documentation
        Auth.auth().createUser(withEmail: trimmedEmail, password: password) { authResult, error in
            if error == nil && authResult != nil {
                // Create profileData dictionary
                let profileData: [String : Any] = [
                    "firstName": fullNameArr[0],
                    "lastName": fullNameArr[1],
                    "hometown": trimmedHometown,
                    "concentration": trimmedConcentration,
                    "gradYear": Int(gradYear)!,
                    "house": trimmedHouse,
                    "roomNumber": roomNumber,
                    "age": Int(age)!,
                    "cellPhoneNumber": Int(cellPhoneNumber)!,
                ]
            
                
                // Upload user profile to the cloud
                let ref = Database.database().reference()
                self.roomIdentifier = self.createRoomIdentifier(house: house, roomNumber: roomNumber)
                ref.child(self.roomIdentifier!).child(trimmedEmail.replacingOccurrences(of: "@", with: "_").replacingOccurrences(of: ".", with: "_")).setValue(profileData)
        
                self.userCreated = true
                print("User created")
            } else {
                print(error!)
            }
        }
        
        // Hide button when hit
        signUp.isHidden = true
    }
    
    func createRoomIdentifier(house: String, roomNumber: String) -> String {
        return house.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: " ")[0].lowercased() + roomNumber.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: " ")[0].lowercased()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return self.userCreated
    }
}
