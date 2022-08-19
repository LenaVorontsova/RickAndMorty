//
//  MainViewController.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 17.08.2022.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    @IBOutlet private weak var charactersButton: UIButton!
    @IBOutlet private weak var locationsButton: UIButton!
    @IBOutlet private weak var episodesButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func characterButtonTap(_ sender: Any) {
        
        charactersButton.backgroundColor = UIColor.link
        performSegue(withIdentifier: "characterVC", sender: nil)
        charactersButton.backgroundColor = UIColor.clear
    }
    
    @IBAction private func locationButtonTap(_ sender: Any) {
        
        locationsButton.backgroundColor = UIColor.link
        performSegue(withIdentifier: "locationVC", sender: nil)
        locationsButton.backgroundColor = UIColor.clear
    }
    
    @IBAction private func episodeButtonTap(_ sender: Any) {
        
        episodesButton.backgroundColor = UIColor.link
        performSegue(withIdentifier: "episodeVC", sender: nil)
        episodesButton.backgroundColor = UIColor.clear
    }
}
