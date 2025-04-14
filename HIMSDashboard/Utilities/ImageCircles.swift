//
//  ImageCircles.swift
//  HIMSDashboard
//
//  Created by ATHENTECH INDIA on 17/07/23.
//

import Foundation
import AVKit
extension UIImageView {
  public func maskCircle(anyImage: UIImage) {
      self.contentMode = UIView.ContentMode.scaleAspectFill
    self.layer.cornerRadius = self.frame.height / 2
    self.layer.masksToBounds = false
    self.clipsToBounds = true
   self.image = anyImage
  }
}
