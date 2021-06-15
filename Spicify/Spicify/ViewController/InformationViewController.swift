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
    @IBOutlet weak var detailAroma: UILabel!
    @IBOutlet weak var detailTaste: UILabel!
    
    // Predefine spices
    public let spicesList : [Spice] = [
        Spice(nameID: "jahe", name: "Ginger", indoName: "Jahe", bioName: "Zingiber officinale", aroma: "Pungent - Spicy", taste: "Peppery Sweet", type: SpiceType.ginger),
        Spice(nameID: "kunyit", name: "Turmeric", indoName: "Kunyit", bioName: "Curcuma longa", aroma: "Orangey Ginger", taste: "Pungent - Bitter", type: SpiceType.turmeric),
        Spice(nameID: "lengkuas", name: "Galangal", indoName: "Lengkuas", bioName: "Alphinia galanga", aroma: "Peppery Strong", taste: "Extra Citrusy", type: SpiceType.galangal),
        Spice(nameID: "kencur", name: "Aromatic Ginger", indoName: "Kencur", bioName: "Kaempferia galanga", aroma: "Slightly Spicy", taste: "Sickly Sweet", type: SpiceType.aromaticGinger)
    ]
    
    var prediction      : String?
    var flagfromScan    : Bool = false
    var selectedSpice   : Spice?
    var relatedSpices   : [Spice]?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        usageCollectionView.delegate        = self
        usageCollectionView.dataSource      = self
        relatedCollectionView.delegate      = self
        relatedCollectionView.dataSource    = self
        
        // validation parameter prediction from scan
        if prediction == nil || prediction == "" {
            selectedSpice = spicesList[0]
        } else {
            selectedSpice = spicesList.filter{ $0.nameID == prediction }[0]
        }
        // load the spice details
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if flagfromScan {
            // Showing pop up alert spice discovered
            showAlert()
        }
    }
    
    // Take from scan result and validate
    func loadData(){
        
        // validation related spices
        relatedSpices = spicesList.filter{ $0.name != selectedSpice?.name }
        
        // debug
        for item in relatedSpices! {
            print(item.name as Any)
        }
        
        // reload the collectionViews for each spice selected
        DispatchQueue.main.async {
            self.relatedCollectionView.reloadData()
            self.usageCollectionView.reloadData()
        }
        
        // Update layout for selected spices
        detailImage.image   = selectedSpice?.image
        detailName.text     = selectedSpice?.name
        detailIndoName.text = selectedSpice?.indoName
        detailBioName.text  = selectedSpice?.bioName
        detailAroma.text    = selectedSpice?.aroma
        detailTaste.text    = selectedSpice?.taste
        
        //showAlert()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // showing the qty of usage cell
        if collectionView == self.usageCollectionView {
            
            let usagelist = selectedSpice?.usageList
            return usagelist!.count
        }
        else {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.relatedCollectionView {
            print("clicked:")
            
            selectedSpice = self.relatedSpices?[indexPath.item]
            loadData()
        }
    }
    
    func showAlert(){
        
        let jaheDiscover        = UserDefaults.standard.bool(forKey: "jaheDiscovered")
        let kunyitDiscover      = UserDefaults.standard.bool(forKey: "kunyitDiscovered")
        let lengkuasDiscover    = UserDefaults.standard.bool(forKey: "lengkuasDiscovered")
        let kencurDiscover      = UserDefaults.standard.bool(forKey: "kencurDiscovered")
        
        var flagShow = false
        
        switch selectedSpice?.nameID {
        case "jahe":
            if jaheDiscover == false {
                flagShow = true
                UserDefaults.standard.setValue(true, forKey: "jaheDiscovered")
            } else { flagShow = false }
            
        case "kunyit":
            if kunyitDiscover == false {
                flagShow = true
                UserDefaults.standard.setValue(true, forKey: "kunyitDiscovered")
            } else { flagShow = false }
            
        case "lengkuas":
            if lengkuasDiscover == false {
                flagShow = true
                UserDefaults.standard.setValue(true, forKey: "lengkuasDiscovered")
            } else { flagShow = false }
            
        case "kencur":
            if kencurDiscover == false {
                flagShow = true
                UserDefaults.standard.setValue(true, forKey: "kencurDiscovered")
            } else { flagShow = false }
            
        default:
            return
        }
        
        if flagShow == true {
            
            if let itemName = selectedSpice?.name {
                
                // create the alert
                let alert = UIAlertController(title: "\(itemName) Discovered !", message: "\(itemName) is available now in the Library", preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    // Back button action (unwind segue to the previous page where it comes from)
    /*@IBAction func unwindBack (_ sender: UIStoryboardSegue) {
        performSegue(withIdentifier: "backtoLibrary", sender: self)
    }*/

}


