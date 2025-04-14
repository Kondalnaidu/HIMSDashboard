//
//  PatientCollectionCell.swift
//  HIMSDashboard
//
//  Created by ATHENTECH INDIA on 21/07/23.
//

import UIKit

class PatientCollectionCell: UICollectionViewCell {
    @IBOutlet weak var designView: UIView!
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var priceLbl: UILabel!
    @IBOutlet weak var patientImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.designView.layer.cornerRadius = 8
        self.designView.clipsToBounds = true
        
    }

}
