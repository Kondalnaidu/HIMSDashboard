//
//  SideMenuTableCell.swift
//  HIMSDashboard
//
//  Created by ATHENTECH INDIA on 17/07/23.
//

import UIKit

class SideMenuTableCell: UITableViewCell {

    @IBOutlet weak var sideNameLbl: UILabel!
    @IBOutlet weak var sideImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
     }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     }
    
}
