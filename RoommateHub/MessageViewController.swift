//
//  MessageBoardViewController.swift
//  RoommateHub
//
//  Created by Geena Kim on 11/28/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//

import Foundation

import UIKit

class MessageViewController: UIViewController {
    @IBOutlet var messageBoardTitle: UILabel!
    @IBOutlet var contentTextView: UITextView!
    
    var message: Message? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        contentTextView.text = message!.content
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        message!.content = contentTextView.text
        MessageManager.shared.saveMessage(message: message!)
    }
    @IBAction func deleteMessage() {
        MessageManager.shared.deleteMessage(message: message!)
        navigationController?.popViewController(animated: true)
    }

}

