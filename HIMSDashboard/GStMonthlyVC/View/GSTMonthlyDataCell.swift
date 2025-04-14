//
//  GSTMonthlyDataCell.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 19/02/24.
//

import UIKit

class GSTMonthlyDataCell: UITableViewCell {

    @IBOutlet weak var totalLbl: UILabel!
    @IBOutlet weak var saleDateLbl: UILabel!
    
    
    @IBOutlet weak var zeroTaxbleLbl: UILabel!
    
    @IBOutlet weak var fiveTaxbleLbl: UILabel!
    
    @IBOutlet weak var fiveGstLbl: UILabel!
    
    
    @IBOutlet weak var twelTaxbleLbl: UILabel!
    
    
    @IBOutlet weak var twelgstlLbl: UILabel!
    
    
    @IBOutlet weak var eightenTaxbleLbl: UILabel!
    
    @IBOutlet weak var eighteenGstLbl: UILabel!
    
    
    @IBOutlet weak var twentyEightTaxbleLbl: UILabel!
    
    @IBOutlet weak var twentyEightyGstLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     }
    
}
