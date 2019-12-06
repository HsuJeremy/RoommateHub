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

class LoginViewController: UIViewController, UITextFieldDelegate {
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
        view.endEditing(true)
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return self.userSignedIn
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginToHome", let destination = segue.destination as? HomeViewController {
            destination.roomIdentifier = roomIdentifier!
        }
    }
    
    // From Code Pro on YouTube
    private func configureTextFields() {
        email.delegate = self
        password.delegate = self
        house.delegate = self
        roomNumber.delegate = self
    }
    
    // Code structure from Vinoth Vino on StackOverflow
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == email {
            textField.resignFirstResponder()
            password.becomeFirstResponder()
        } else if textField == password {
            textField.resignFirstResponder()
            house.becomeFirstResponder()
        } else if textField == house {
            textField.resignFirstResponder()
            roomNumber.becomeFirstResponder()
        } else if textField == roomNumber {
            textField.resignFirstResponder()
        }
        return true 
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Congifure UITextField delegates and tap gestures
        configureTextFields()
        configureTapGesture()
        
        // Appropriate keyboards for each UITextField
        self.email.keyboardType = UIKeyboardType.emailAddress
        self.password.keyboardType = UIKeyboardType.asciiCapable
        self.house.keyboardType = UIKeyboardType.asciiCapable
        self.roomNumber.keyboardType = UIKeyboardType.asciiCapable
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
}
