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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    @IBAction func DismissBtndidTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        
        
        
    }
    
}
