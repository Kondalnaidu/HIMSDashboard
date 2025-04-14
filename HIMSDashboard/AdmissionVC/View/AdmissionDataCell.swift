//
//  AdmissionDataCell.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 05/12/23.
//

import UIKit

class AdmissionDataCell: UITableViewCell {

    @IBOutlet weak var dischargeBtn: UIButton!
    @IBOutlet weak var admissionBtn: UIButton!
    @IBOutlet weak var discharggeLbl: UILabel!
    @IBOutlet weak var admissionLbl: UILabel!
    @IBOutlet weak var monthLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
