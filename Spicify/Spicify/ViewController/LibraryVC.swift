
import UIKit

class LibraryVC: UIViewController, UITableViewDataSource {
    
    let spicesLibrary = [
        spiceLibrary(titleName: "Ginger", subName: "Zingiber officinale", spiceImage: #imageLiteral(resourceName: "Ginger Main")),
        spiceLibrary(titleName: "Turmeric", subName: "Curcuma longa", spiceImage: #imageLiteral(resourceName: "Turmeric Main")),
        spiceLibrary(titleName: "Galangal", subName: "Alpinia galanga", spiceImage: #imageLiteral(resourceName: "Galangal Main")),
        spiceLibrary(titleName: "Aromatic Ginger", subName: "Kaempferia galanga", spiceImage: #imageLiteral(resourceName: "Aromatic Ginger Main"))
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return spicesLibrary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "libraryCell") as! LibraryTableVC
        
        cell.libraryImageView.layer.cornerRadius = 9
        cell.layer.cornerRadius = 9
        cell.libraryImageView.image = #imageLiteral(resourceName: "DetailspiceCardHeader")
        cell.spicesImageView.image = spicesLibrary[indexPath.row].spiceImage
        cell.spicesTitleLabel.text = spicesLibrary[indexPath.row].titleName
        cell.spicesSubLabel.text = spicesLibrary[indexPath.row].subName
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
