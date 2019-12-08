//
//  MessageBoardViewController.swift
//  RoommateHub
//
//  Created by Geena Kim on 11/28/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class MessageViewController: UIViewController {
    @IBOutlet weak var messageContent: UILabel!
    @IBOutlet weak var time: UILabel!
    
    var roomIdentifier: String? = nil
    var message: String? = nil
    var timeStamp: String? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        messageContent.text = message!
        time.text = "⏰ Posted on \(timeStamp!)"
    }
}

