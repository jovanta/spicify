//
//  InformationViewController.swift
//  Spicify
//
//  Created by Dian Dinihari on 07/06/21.
//

import UIKit

class InformationViewController: UIViewController {
    
    @IBOutlet weak var spicelabel: UILabel!
    var prediction = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spicelabel.text = prediction
        spicelabel.sizeToFit()
        // Do any additional setup after loading the view.
    }
    
}
