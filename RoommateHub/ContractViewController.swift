//
//  ContractViewController.swift
//  RoommateHub
//
//  Created by Geena Kim on 11/28/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//

import Foundation

import UIKit

class ContractViewController: UIViewController {
    @IBOutlet var contractTitle: UILabel!
    
    @IBAction func about(_ sender: Any) {
        performSegue(withIdentifier: "about", sender: sender)
    }


}
