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
    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var detailIndoName: UILabel!
    @IBOutlet weak var detailBioName: UILabel!
    @IBOutlet weak var detailImage: UIImageView!
    
    var prediction = String()
    
    // Predefine spices
    public let spicesList : [Spice] = [
        Spice(name: "Ginger", indoName: "Jahe", bioName: "Zingiber officinale", aroma: "Pungent - Spicy", taste: "Peppery Sweet", type: SpiceType.ginger),
        Spice(name: "Turmeric", indoName: "Kunyit", bioName: "Curcuma longa", aroma: "Orangey Ginger", taste: "Pungent - Bitter", type: SpiceType.turmeric),
        Spice(name: "Galangal", indoName: "Lengkuas", bioName: "Alphinia galanga", aroma: "Peppery Strong", taste: "Extra Citrusy", type: SpiceType.galangal),
        Spice(name: "Aromatic Ginger", indoName: "Kencur", bioName: "Kaempferia galanga", aroma: "Slightly Spicy", taste: "Sickly Sweet", type: SpiceType.aromaticGinger)
    ]
    
    var selectedSpice : Spice?
    var relatedSpices : [Spice]?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        usageCollectionView.delegate = self
        usageCollectionView.dataSource = self
        relatedCollectionView.delegate = self
        relatedCollectionView.dataSource = self
        
        loadData()
    }
    
    // Take from scan result and validate
    func loadData(){
        // validasi scan result to display the spice detail
        // contoh : selectedSpice = spicesList.filter{ $0.name == selectedSpice?.name }
        selectedSpice = spicesList[2]
        
        // validasi related spices
        relatedSpices = spicesList.filter{ $0.name != selectedSpice?.name }
        
        // Update layout for selected spices
        detailImage.image = selectedSpice?.image
        detailName.text = selectedSpice?.name
        detailIndoName.text = selectedSpice?.indoName
        detailBioName.text = selectedSpice?.bioName
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // showing the qty of usage cell
        if collectionView == self.usageCollectionView {
            
            let usagelist = selectedSpice?.usageList
            return usagelist!.count
        }
        else{
            // showing the qty of related cell
            return relatedSpices!.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.usageCollectionView {
            
            // usage details
            let cellUsage = collectionView.dequeueReusableCell(withReuseIdentifier: "UsageCell", for: indexPath) as! UsageCollectionViewCell
            
            cellUsage.usageImage.image = selectedSpice?.usageList?[indexPath.item].usageImage
            cellUsage.usageLabel.text = selectedSpice?.usageList?[indexPath.item].usageLabel
            return cellUsage
        }
        
        else {
            // related spices
            let cellRelated = collectionView.dequeueReusableCell(withReuseIdentifier: "RelatedCell", for: indexPath) as! RelatedSpiceCollectionViewCell
            
            cellRelated.relatedSpiceLabel.text = relatedSpices?[indexPath.item].name
            cellRelated.relatedSpiceImage.image = relatedSpices?[indexPath.item].relatedImage
            return cellRelated
        }
        
    }
    // Back button action (unwind segue to the previous page where it comes from)
    @IBAction func unwindBack (_ sender: UIStoryboardSegue) {
        
    }

}


