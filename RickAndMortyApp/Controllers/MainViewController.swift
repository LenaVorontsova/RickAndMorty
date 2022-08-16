import UIKit
import SnapKit

class MainViewController: UIViewController {
    @IBOutlet weak var charactersButton: UIButton!
    @IBOutlet weak var locationsButton: UIButton!
    @IBOutlet weak var episodesButton: UIButton!
//    private var charactersButton: UIButton = {
//        let charactersButton: UIButton = .init()
//        //charactersButton.backgroundColor = UIColor(red: 200/255, green: 246/255, blue: 236/255, alpha: 1)
//        charactersButton.backgroundColor = .clear
//
//    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func characterButtonTap(_ sender: Any) {
//        if charactersButton.backgroundColor == UIColor.clear {
//            charactersButton.backgroundColor = UIColor.link
//        } else if charactersButton.backgroundColor == UIColor.link {
//            charactersButton.backgroundColor = UIColor.clear
//        }
        charactersButton.backgroundColor = UIColor.link
        performSegue(withIdentifier: "characterVC", sender: nil)
        charactersButton.backgroundColor = UIColor.clear
    }
    
    @IBAction func locationButtonTap(_ sender: Any) {
//        if locationsButton.backgroundColor == UIColor.clear {
//            locationsButton.backgroundColor = UIColor.link
//        } else if locationsButton.backgroundColor == UIColor.link {
//            locationsButton.backgroundColor = UIColor.clear
//        }
        locationsButton.backgroundColor = UIColor.link
        performSegue(withIdentifier: "locationVC", sender: nil)
        locationsButton.backgroundColor = UIColor.clear
    }
    
    @IBAction func episodeButtonTap(_ sender: Any) {
//        if episodesButton.backgroundColor == UIColor.clear {
//            episodesButton.backgroundColor = UIColor.link
//        } else if episodesButton.backgroundColor == UIColor.link {
//            episodesButton.backgroundColor = UIColor.clear
//        }
        episodesButton.backgroundColor = UIColor.link
        performSegue(withIdentifier: "episodeVC", sender: nil)
        episodesButton.backgroundColor = UIColor.clear
    }
}

