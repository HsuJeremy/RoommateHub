//
//  RoommateViewController.swift
//  RoommateHub
//
//  Created by Jeremy Hsu on 12/5/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//

import Foundation
import UIKit

class RoommateViewController: UIViewController {
    @IBOutlet weak var something: UILabel!
    @IBOutlet weak var another: UILabel!
    
    
    var roommate: Roommate? = nil
    
    override func viewWillAppear(_ animated: Bool) {
        print(something.text)
        another.text = roommate!.firstName
    }
}
