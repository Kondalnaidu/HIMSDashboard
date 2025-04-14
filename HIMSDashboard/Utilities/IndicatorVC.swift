//
//  IndicatorVC.swift
//  HIMSDashboard
//
//  Created by ATHENTECH INDIA on 20/07/23.
//

import Foundation
import UIKit
import MBProgressHUD
extension UIViewController {
   func showIndicator() {
      let Indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
      Indicator.label.text = "Loading"
      Indicator.isUserInteractionEnabled = false
      Indicator.detailsLabel.text = "Please Wait"
      Indicator.show(animated: true)
   }
   func hideIndicator() {
      MBProgressHUD.hide(for: self.view, animated: true)
   }
}


extension  UIViewController {

    func showAlert(withTitle title: String, withMessage message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: { action in
        })
        let cancel = UIAlertAction(title: "Cancel", style: .default, handler: { action in
        })
        alert.addAction(ok)
        alert.addAction(cancel)
        DispatchQueue.main.async(execute: {
            self.present(alert, animated: true)
        })
    }
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
