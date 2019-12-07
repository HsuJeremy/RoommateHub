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
                ref.child(self.roomIdentifier!).child("users").child(trimmedEmail.replacingOccurrences(of: "@", with: "_").replacingOccurrences(of: ".", with: "_")).setValue(profileData)
        
                self.userCreated = true
                self.signUp.isHidden = true
                print("User created")
            } else {
                print(error!)
            }
        }
    }
    
    func createRoomIdentifier(house: String, roomNumber: String) -> String {
        return house.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: " ")[0].lowercased() + roomNumber.trimmingCharacters(in: .whitespacesAndNewlines).components(separatedBy: " ")[0].lowercased()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return self.userCreated
    }
    
    // From Code Pro on YouTube
    private func configureTextFields() {
        fullName.delegate = self
        hometown.delegate = self
        concentration.delegate = self
        gradYear.delegate = self
        house.delegate = self
        roomNumber.delegate = self
        age.delegate = self
        cellPhoneNumber.delegate = self
        email.delegate = self
        password.delegate = self
        passwordConfirm.delegate = self
    }
    
    // Code structure from Vinoth Vino on StackOverflow
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == fullName {
            textField.resignFirstResponder()
            hometown.becomeFirstResponder()
        } else if textField == hometown {
            textField.resignFirstResponder()
            concentration.becomeFirstResponder()
        } else if textField == concentration {
            textField.resignFirstResponder()
            gradYear.becomeFirstResponder()
        } else if textField == gradYear {
            textField.resignFirstResponder()
            house.becomeFirstResponder()
        } else if textField == house {
            textField.resignFirstResponder()
            roomNumber.becomeFirstResponder()
        } else if textField == roomNumber {
            textField.resignFirstResponder()
            age.becomeFirstResponder()
        } else if textField == age {
            textField.resignFirstResponder()
            cellPhoneNumber.becomeFirstResponder()
        } else if textField == cellPhoneNumber {
            textField.resignFirstResponder()
            email.becomeFirstResponder()
        } else if textField == email {
            textField.resignFirstResponder()
            password.becomeFirstResponder()
        } else if textField == password {
            textField.resignFirstResponder()
            passwordConfirm.becomeFirstResponder()
        } else if textField == passwordConfirm {
            textField.resignFirstResponder()
        }
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Congifure UITextField delegates and tap gestures
        configureTextFields()
        configureTapGesture()
        
        // Relevant keyboards for each UITextField
        setRelevantKeyboards()
    }
    
    // From Code Pro on YouTube
    private func configureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    // From Code Pro on YouTube
    @objc func handleTap() {
        print("Handle tap was called")
        view.endEditing(true)
    }
    
    // Sets relevant keyboards for each UITextField
    private func setRelevantKeyboards() {
        self.fullName.keyboardType = UIKeyboardType.asciiCapable
        self.hometown.keyboardType = UIKeyboardType.asciiCapable
        self.concentration.keyboardType = UIKeyboardType.asciiCapable
        self.gradYear.keyboardType = UIKeyboardType.numberPad
        self.house.keyboardType = UIKeyboardType.asciiCapable
        self.roomNumber.keyboardType = UIKeyboardType.namePhonePad
        self.age.keyboardType = UIKeyboardType.numberPad
        self.cellPhoneNumber.keyboardType = UIKeyboardType.phonePad
        self.email.keyboardType = UIKeyboardType.emailAddress
        self.password.keyboardType = UIKeyboardType.asciiCapable
        self.passwordConfirm.keyboardType = UIKeyboardType.asciiCapable
    }
}
