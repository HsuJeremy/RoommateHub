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
    @IBOutlet weak var contextTextView: UITextView!
    @IBOutlet var timeLabel: UILabel!
    
    var roomIdentifier: String? = nil
    var messageContent: String? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        contextTextView.text = messageContent!
    }
}

