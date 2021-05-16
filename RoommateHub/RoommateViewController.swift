//
//  RoommateViewController.swift
//  RoommateHub
//
//  Created by Jeremy Hsu on 12/5/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

class RoommateViewController: UIViewController, MFMessageComposeViewControllerDelegate {
  @IBOutlet weak var fullName: UILabel!
  @IBOutlet weak var hometown: UILabel!
  @IBOutlet weak var concentration: UILabel!
  @IBOutlet weak var gradYear: UILabel!
  @IBOutlet weak var age: UILabel!
  
  var messageComposeDelegate = self
  
  // From official MFMessageComposeViewController documentation
  @IBAction func message(_ sender: Any) {
    if !MFMessageComposeViewController.canSendText() {
      print("SMS services are not available")
      return
    }
      
    let composeVC = MFMessageComposeViewController()
    composeVC.messageComposeDelegate = self
     
    // Configure the fields of the interface
    composeVC.recipients = [String(roommate!.cellPhoneNumber)]
    composeVC.body = "Hello from RoommateHub!"
     
    // Present the view controller modally
    self.present(composeVC, animated: true, completion: nil)
  }
  
  // From official MFMessageComposeViewController documentation
  func messageComposeViewController(
    _ controller: MFMessageComposeViewController,
    didFinishWith result: MessageComposeResult
  ) {
    // Dismiss the message compose view controller
    controller.dismiss(animated: true, completion: nil)
  }
  
  var roommate: Roommate? = nil
  
  override func viewWillAppear(_ animated: Bool) {
    fullName.text = "\(roommate!.firstName) \(roommate!.lastName)"
    hometown.text = "📍 \(roommate!.hometown)"
    concentration.text = "📚 \(roommate!.concentration)"
    gradYear.text = "🎓 \(String(roommate!.gradYear))"
    age.text = "🎂 \(String(roommate!.age))"
  }
}
