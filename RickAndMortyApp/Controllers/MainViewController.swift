import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var charactersButton: UIButton!
    @IBOutlet weak var locationsButton: UIButton!
    @IBOutlet weak var episodesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func characterButtonTap(_ sender: Any) {
        
        charactersButton.backgroundColor = UIColor.link
        performSegue(withIdentifier: "characterVC", sender: nil)
        charactersButton.backgroundColor = UIColor.clear
    }
    
    @IBAction func locationButtonTap(_ sender: Any) {
        
        locationsButton.backgroundColor = UIColor.link
        performSegue(withIdentifier: "locationVC", sender: nil)
        locationsButton.backgroundColor = UIColor.clear
    }
    
    @IBAction func episodeButtonTap(_ sender: Any) {
        
        episodesButton.backgroundColor = UIColor.link
        performSegue(withIdentifier: "episodeVC", sender: nil)
        episodesButton.backgroundColor = UIColor.clear
    }
}

