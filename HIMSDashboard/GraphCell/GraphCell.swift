//
//  GraphCell.swift
//  Demo
//
//  Created by Kondal Naidu on 18/07/23.
//

import UIKit
import Charts
import DGCharts
   class GraphCell: UITableViewCell {
 
       @IBOutlet weak var rightArrowBtn: UIButton!
       @IBOutlet weak var barchatiew: BarChartView!
       @IBOutlet weak var calenderBtn: UIButton!
       @IBOutlet weak var leftArrowBtn: UIButton!
       
       @IBOutlet weak var datelbl: UILabel!
       
       override func awakeFromNib() {
        super.awakeFromNib()
           
        // Initialization code
           calenderBtn.setTitle("", for: .normal)
           leftArrowBtn.setTitle("", for: .normal)
           rightArrowBtn.setTitle("", for: .normal)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     }
       
       
}
