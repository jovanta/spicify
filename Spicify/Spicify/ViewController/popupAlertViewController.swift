//
//  popupAlertViewController.swift
//  Spicify
//
//  Created by Daffa Satria on 11/06/21.
//

import Foundation
import UIKit


class popupAlertViewController: UIViewController {
    
    
    @IBOutlet weak var dismissBtn: UIButton!
    @IBOutlet weak var alertView: UIView!
    
    
    override func viewDidLoad() {
        dismissBtn.layer.cornerRadius = 7
        alertView.layer.cornerRadius = 8
        
    }
    
    @IBAction func DismissBtndidTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
        
        
    }
    
}
