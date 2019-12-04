//
//  RoommateViewController.swift
//  RoommateHub
//
//  Created by Jeremy Hsu on 12/3/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//
// Repurposed from NoteViewController.swift from Notes app

import UIKit
import MessageUI

class RoommateViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    
    var roommate: Roommate? = nil
    
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var hometownLabel: UILabel!
    @IBOutlet weak var concentrationLabel: UILabel!
    @IBOutlet weak var gradYearLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    // From Apple MessageUI documentation
    @IBAction func sendMessageButton(_ sender: Any) {
        if !MFMessageComposeViewController.canSendText() {
            print("SMS services are not available")
            return
        }
        
        let composeVC = MFMessageComposeViewController()
        composeVC.messageComposeDelegate = self
         
        // Configure the fields of the interface.
        composeVC.recipients = [String(roommate!.number)]
        composeVC.body = "Hello from RoommateHub!"
         
        // Present the view controller modally.
        self.present(composeVC, animated: true, completion: nil)
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController,
                                      didFinishWith result: MessageComposeResult) {
    // Check the result or perform other tasks.
    
    // Dismiss the message compose view controller.
        controller.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fullNameLabel.text = roommate!.firstName + " " + roommate!.lastName
        usernameLabel.text = roommate!.username
        hometownLabel.text = roommate!.hometown
        concentrationLabel.text = roommate!.concentration
        gradYearLabel.text = String(roommate!.year)
        ageLabel.text = String(roommate!.age)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
}
