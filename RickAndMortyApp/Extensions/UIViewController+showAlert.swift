//
//  UIViewController+showAlert.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 29.08.2022.
//

import UIKit
import Rswift

extension UIViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: R.string.alertMessages.errorTitle(), message: "\(message)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: R.string.alertMessages.okTitle(), style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}
