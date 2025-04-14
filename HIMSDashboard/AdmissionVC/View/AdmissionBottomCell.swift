//
//  AdmissionBottomCell.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 05/12/23.
//

import UIKit

class AdmissionBottomCell: UITableViewCell {
@IBOutlet weak var dischargeTotalCountLbl: UILabel!
@IBOutlet weak var admissionTotalCountLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
