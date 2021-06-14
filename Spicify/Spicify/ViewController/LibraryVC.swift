
import UIKit

class LibraryVC: UIViewController, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "libraryCell") as! LibraryTableVC
        
        cell.libraryImageView.layer.cornerRadius = 9
        cell.layer.cornerRadius = 9
        cell.libraryImageView.image = #imageLiteral(resourceName: "DetailspiceCardHeader")
        cell.spicesImageView.image = #imageLiteral(resourceName: "Ginger Main")
        cell.spicesTitleLabel.text = "Ginger"
        cell.spicesSubLabel.text = "Zingiber officinale"
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
