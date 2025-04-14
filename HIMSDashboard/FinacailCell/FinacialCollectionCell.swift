//
//  FinacialCollectionCell.swift
//  Demo
//
//  Created by Kondal Naidu on 18/07/23.
//

import UIKit

class FinacialCollectionCell: UICollectionViewCell {
    @IBOutlet weak var designView: UIView!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var financeImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.designView.layer.cornerRadius = 8
        self.designView.clipsToBounds = true
      //  self.designView.clipsToBounds = true
     }

}
