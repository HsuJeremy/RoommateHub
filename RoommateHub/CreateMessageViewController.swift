//
//  CreateMessageViewController.swift
//  RoommateHub
//
//  Created by Jeremy Hsu on 12/8/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//
// ComposeViewController from CodeWithChris on YouTube

import Foundation
import UIKit
import FirebaseDatabase

class CreateMessageViewController: UIViewController {
  @IBOutlet weak var textView: UITextView!
  @IBOutlet weak var createMessage: UIButton!
  
  var roomIdentifier: String? = nil
  var timeStamp: String? = nil
  
  @IBAction func createMessage(_ sender: Any) {
    let roomReference = Database.database().reference().child(self.roomIdentifier!)
    roomReference.child("messageBoard").child(self.timeStamp!).setValue(textView.text)
    createMessage.isHidden = true
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Configure UITextField delegates and tap gestures
    configureTapGesture()
  }
  
  // From Code Pro on YouTube
  private func configureTapGesture() {
    let tapGesture = UITapGestureRecognizer(
      target: self,
      action: #selector(CreateMessageViewController.handleTap)
    )
    view.addGestureRecognizer(tapGesture)
  }

  // From Code Pro on YouTube
  @objc func handleTap() {
    print("Handle tap was called")
    view.endEditing(true)
  }
}
