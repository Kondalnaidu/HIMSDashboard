//
//  RevenueTotalCell.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 27/12/23.
//

import UIKit

class RevenueTotalCell: UITableViewCell {
@IBOutlet weak var outTotalLbl: UILabel!
@IBOutlet weak var intotalLbl: UILabel!
@IBOutlet weak var pharmcyTotalbl: UILabel!
@IBOutlet weak var diagonoTotalLvl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
