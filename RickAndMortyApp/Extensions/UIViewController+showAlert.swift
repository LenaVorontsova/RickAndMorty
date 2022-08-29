//
//  UIViewController+showAlert.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 29.08.2022.
//

import UIKit

extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: "\(message)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}
