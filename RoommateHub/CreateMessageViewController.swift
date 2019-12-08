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
    
    var roomIdentifier: String? = nil
    var timeStamp: String? = nil 
    
    @IBAction func createMessage(_ sender: Any) {
        let ref = Database.database().reference()
        
        print(self.roomIdentifier)
        print(self.timeStamp)
        ref.child(self.roomIdentifier!).child("messageBoard").child(self.timeStamp!).setValue(textView.text)
        
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
