//
//  ContractViewController.swift
//  RoommateHub
//
//  Created by Geena Kim on 11/28/19.
//  Copyright © 2019 Jeremy Hsu. All rights reserved.
//

import Foundation

import UIKit

class ContractViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var contractTitle: UILabel!
    
    @IBOutlet weak var contractImage: UIImageView!
    
    
    @IBAction func selectPhoto(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let picker = UIImagePickerController()
            
            picker.delegate = self
            picker.sourceType = .photoLibrary
            picker.allowsEditing = false
            
            present(picker, animated: true, completion: nil)
        }
    }
    
    @IBAction func about(_ sender: Any) {
        performSegue(withIdentifier: "about", sender: sender)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated: true, completion: nil)
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            contractImage.image = image
            print("Displayed!")
        }
    }
}
