//
//  GSTDataCell.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 11/02/24.
//

import UIKit

class GSTDataCell: UITableViewCell {
    @IBOutlet weak var gstLbl: UILabel!
    @IBOutlet weak var netLbl: UILabel!
    @IBOutlet weak var igLbl: UILabel!
    @IBOutlet weak var cgLbl: UILabel!
    @IBOutlet weak var sgLbl: UILabel!
    @IBOutlet weak var txtAmtLbl: UILabel!
    @IBOutlet weak var totalLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
