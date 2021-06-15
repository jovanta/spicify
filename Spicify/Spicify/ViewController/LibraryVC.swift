
import UIKit

class LibraryVC: UIViewController, UITableViewDataSource {
    
    public let spicesList : [Spice] = [
        Spice(nameID: "jahe", name: "Ginger", indoName: "Jahe", bioName: "Zingiber officinale", aroma: "Pungent - Spicy", taste: "Peppery Sweet", type: SpiceType.ginger),
        Spice(nameID: "kunyit", name: "Turmeric", indoName: "Kunyit", bioName: "Curcuma longa", aroma: "Orangey Ginger", taste: "Pungent - Bitter", type: SpiceType.turmeric),
        Spice(nameID: "lengkuas", name: "Galangal", indoName: "Lengkuas", bioName: "Alphinia galanga", aroma: "Peppery Strong", taste: "Extra Citrusy", type: SpiceType.galangal),
        Spice(nameID: "kencur", name: "Aromatic Ginger", indoName: "Kencur", bioName: "Kaempferia galanga", aroma: "Slightly Spicy", taste: "Sickly Sweet", type: SpiceType.aromaticGinger)
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spicesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "libraryCell") as! LibraryTableVC
        
        cell.libraryImageView.layer.cornerRadius = 9
        cell.layer.cornerRadius = 9
        cell.libraryImageView.image = #imageLiteral(resourceName: "DetailspiceCardHeader")
        cell.spicesImageView.image = spicesList[indexPath.row].image?.noir
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
    
    //let image = UIImage(...)
    //let noirImage = image.noir // noirImage is an optional UIImage (UIImage?)
}

