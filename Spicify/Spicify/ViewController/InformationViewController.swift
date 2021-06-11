//
//  InformationViewController.swift
//  Spicify
//
//  Created by Dian Dinihari on 07/06/21.
//

import UIKit

class InformationViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var usageCollectionView: UICollectionView!
    @IBOutlet weak var relatedCollectionView: UICollectionView!
    @IBOutlet weak var spiceLabel: UILabel!
    
    let spiceUsage = ["Drinks","Stir Fry", "Soups", "Curry"]
    
    let relatedSpice = ["Turmeric", "Galangal", "Aromatic Ginger"]
    
    let usageImage: [UIImage] = [
        UIImage(named: "Glazing Icon")!,
        UIImage(named: "Dressing Icon")!,
        UIImage(named: "Marinate Icon")!,
        UIImage(named: "Infusion Icon")!
    ]
    
    let Rempah = [
        Spice()
    
        
    ]
    
    
    var prediction = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        spiceLabel.text = prediction
        spiceLabel.sizeToFit()
        // Do any additional setup after loading the view.
        
        usageCollectionView.delegate = self
        usageCollectionView.dataSource = self
        
        relatedCollectionView.delegate = self
        relatedCollectionView.dataSource = self
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.usageCollectionView {
            
            return spiceUsage.count
        }
        return relatedSpice.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.usageCollectionView {
            
            let cellUsage = collectionView.dequeueReusableCell(withReuseIdentifier: "UsageCell", for: indexPath) as! UsageCollectionViewCell
            
            cellUsage.usageImage.image = usageImage[indexPath.item]
            cellUsage.usageLabel.text = spiceUsage[indexPath.item]
            
            return cellUsage
        }
        
        else {
            
            let cellRelated = collectionView.dequeueReusableCell(withReuseIdentifier: "RelatedCell", for: indexPath) as! RelatedSpiceCollectionViewCell
            
            cellRelated.relatedSpiceLabel.text = relatedSpice[indexPath.item]
            
            return cellRelated
        }
        
    }
    
}
