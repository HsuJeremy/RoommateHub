//
//  LoginViewController.swift
//  RoommateHub
//
//  Created by Jeremy Hsu on 12/4/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController, UITextFieldDelegate {
  @IBOutlet weak var email: UITextField!
  @IBOutlet weak var password: UITextField!
  @IBOutlet weak var house: UITextField!
  @IBOutlet weak var roomNumber: UITextField!
  
  var userSignedIn: Bool = false
  var sentHouse: String? = nil
  var sentRoomNumber: String? = nil
  var sentEmail: String? = nil
  
  @IBAction func signup(_ sender: Any) {
    performSegue(withIdentifier: "loginToSignup", sender: Any?.self)
  }
  
  @IBAction func loginAction(_ sender: Any) {
    // Check that all the user entries are valid and trim responses
    guard let email = email.text else { return }
    let trimmedEmail = email
                         .trimmingCharacters(in: .whitespacesAndNewlines)
                         .components(separatedBy: " ")[0]
    self.sentEmail = trimmedEmail
    guard let password = password.text else { return }
    guard let house = house.text else { return }
    self.sentHouse = house
                       .trimmingCharacters(in: .whitespacesAndNewlines)
                       .components(separatedBy: " ")[0]
                       .lowercased()
    guard let roomNumber = roomNumber.text else { return }
    self.sentRoomNumber = roomNumber
                            .trimmingCharacters(in: .whitespacesAndNewlines)
                            .components(separatedBy: " ")[0]
                            .lowercased()
      
    // From official Firebase documentation
    Auth.auth().signIn(withEmail: trimmedEmail, password: password) { [weak self] authResult, error in
      guard let strongSelf = self else { return }
      if error == nil && authResult != nil {
        let roomIdentifier = (self?.sentHouse!)! + (self?.sentRoomNumber!)!
        
        // Verify that roomIdentifier exists in database
        let ref = Database.database().reference()
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
          let value = snapshot.value as? NSDictionary
          let keys = value!.allKeys
          
          // Line to cast NSArray to Array by Patrick from StackOverflow
          let roomsArray: [String] = keys.compactMap({ $0 as? String })
          
          // Allow segue only if the roomIdentifier is contained in the database
          if roomsArray.contains(roomIdentifier) {
            print("Signed in")
            self!.performSegue(withIdentifier: "loginToHome", sender: Any?.self)
          } else {
            print("Incorrect room")
            // self?.errorLabel.text = "Incorrect room"
          }
        }) { error in
          print(error.localizedDescription)
        }
      } else {
        print(error)
      }
    }
    view.endEditing(true)
  }
  
  // Prevent segue from automatically triggering upon button action
  override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
    return false
  }
  
  // Send house, roomNumber, and email to HomeViewController
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "loginToHome",
       let destination = segue.destination as? HomeViewController {
      destination.house = self.sentHouse!
      destination.roomNumber = self.sentRoomNumber!
      destination.email = self.sentEmail!
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
    
    // Configure UITextField delegates and tap gestures
    configureTextFields()
    configureTapGesture()
    
    // Relevant keyboards for each UITextField
    setRelevantKeyboards()
  }
  
  // From Code Pro on YouTube
  private func configureTapGesture() {
    let tapGesture = UITapGestureRecognizer(
      target: self,
      action: #selector(LoginViewController.handleTap)
    )
    view.addGestureRecognizer(tapGesture)
  }
  
  // From Code Pro on YouTube
  @objc func handleTap() {
    view.endEditing(true)
  }
  
  // Set relevant keyboards for each UITextField
  private func setRelevantKeyboards() {
    self.email.keyboardType = UIKeyboardType.emailAddress
    self.password.keyboardType = UIKeyboardType.asciiCapable
    self.house.keyboardType = UIKeyboardType.asciiCapable
    self.roomNumber.keyboardType = UIKeyboardType.asciiCapable
  }
}
