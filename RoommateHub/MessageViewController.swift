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
    //@IBOutlet var messageBoardTitle: UILabel!
    @IBOutlet weak var contextTextView: UITextView!
    @IBOutlet var timeLabel: UILabel!
    
    var roomIdentifier: String? = nil

    var messageContent: String? = nil
    
//    var message: Message? = nil
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        contentTextView.text = message!.content
//        // timeLabel.text = message!.currentTime //turn the int type into a string
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        message!.content = contentTextView.text
//
//        let ref = Database.database().reference()
//
//        print(contentTextView.text)
//        ref.child(self.roomIdentifier!).child("messageBoard").child(message!.currentTime).updateChildValues([
//            "content": contentTextView.text as! NSString,
//            "currentTime": message!.currentTime
//        ])
//
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        contextTextView.text = messageContent!
    }

}

