
import UIKit

class LibraryVC: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    var temp = String()
    
    let jaheDiscover = UserDefaults.standard.bool(forKey: "jaheDiscovered")
    let kunyitDiscover = UserDefaults.standard.bool(forKey: "kunyitDiscovered")
    let lengkuasDiscover = UserDefaults.standard.bool(forKey: "lengkuasDiscovered")
    let kencurDiscover = UserDefaults.standard.bool(forKey: "kencurDiscovered")
    
    public let spicesList : [Spice] = [
        Spice(nameID: "jahe", name: "Ginger", indoName: "Jahe", bioName: "Zingiber officinale", aroma: "Pungent - Spicy", taste: "Peppery Sweet", type: SpiceType.ginger),
        Spice(nameID: "kunyit", name: "Turmeric", indoName: "Kunyit", bioName: "Curcuma longa", aroma: "Orangey Ginger", taste: "Pungent - Bitter", type: SpiceType.turmeric),
        Spice(nameID: "lengkuas", name: "Galangal", indoName: "Lengkuas", bioName: "Alphinia galanga", aroma: "Peppery Strong", taste: "Extra Citrusy", type: SpiceType.galangal),
        Spice(nameID: "kencur", name: "Aromatic Ginger", indoName: "Kencur", bioName: "Kaempferia galanga", aroma: "Slightly Spicy", taste: "Sickly Sweet", type: SpiceType.aromaticGinger)
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spicesList.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        temp = spicesList[indexPath.row].nameID!
        print("this is temp: \(temp)")
        performSegue(withIdentifier: "informationSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "informationSegue" {
            let vc = segue.destination as! InformationViewController
            
            switch temp {
            case "jahe":
                vc.prediction = "jahe"
            case "kunyit":
                vc.prediction = "kunyit"
            case "lengkuas":
                vc.prediction = "lengkuas"
            case "kencur":
                vc.prediction = "kencur"
            default:
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "libraryCell") as! LibraryTableVC
        
        cell.libraryImageView.layer.cornerRadius = 9
        cell.layer.cornerRadius = 9
        cell.libraryImageView.image = #imageLiteral(resourceName: "DetailspiceCardHeader")
        
        switch spicesList[indexPath.row].name {
        case "Ginger":
            if jaheDiscover == false {
                cell.spicesImageView.image = spicesList[indexPath.row].image?.noir
            } else {
                cell.spicesImageView.image = spicesList[indexPath.row].image
            }
        case "Turmeric":
            if kunyitDiscover == false {
                cell.spicesImageView.image = spicesList[indexPath.row].image?.noir
            } else {
                cell.spicesImageView.image = spicesList[indexPath.row].image
            }
        case "Galangal":
            if lengkuasDiscover == false {
                cell.spicesImageView.image = spicesList[indexPath.row].image?.noir
            } else {
                cell.spicesImageView.image = spicesList[indexPath.row].image
            }
        case "Aromatic Ginger":
            if kencurDiscover == false {
                cell.spicesImageView.image = spicesList[indexPath.row].image?.noir
            } else {
                cell.spicesImageView.image = spicesList[indexPath.row].image
            }
        case .none:
            break
        case .some(_):
            break
        }
        
        cell.spicesTitleLabel.text = spicesList[indexPath.row].name
        cell.spicesSubLabel.text = spicesList[indexPath.row].bioName
        cell.spicesView.layer.cornerRadius = 20
        cell.spicesView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
        
        return cell
    }
    
    @IBOutlet weak var libraryTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        libraryTableView.dataSource = self
    }
    
    @IBAction func backtoMainCamera (_ sender: UIStoryboardSegue) {
        performSegue(withIdentifier: "backtoMainCamera", sender: self)
    }
    
}

extension UIImage {
    var noir: UIImage? {
        let context = CIContext(options: nil)
        guard let currentFilter = CIFilter(name: "CIPhotoEffectNoir") else { return nil }
        currentFilter.setValue(CIImage(image: self), forKey: kCIInputImageKey)
        if let output = currentFilter.outputImage,
           let cgImage = context.createCGImage(output, from: output.extent) {
            return UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
        }
        return nil
    }
}


