//
//  GstTotalCell.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 18/02/24.
//

import UIKit

class GstTotalCell: UITableViewCell {
@IBOutlet weak var totalLbl: UILabel!
@IBOutlet weak var taxTotalLbl: UILabel!
@IBOutlet weak var netTotalLbl: UILabel!
@IBOutlet weak var igTotalLbl: UILabel!
@IBOutlet weak var cgTotalLbl: UILabel!
@IBOutlet weak var sgTotalLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
     }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     }
    
}
