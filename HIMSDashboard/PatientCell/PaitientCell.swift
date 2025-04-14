//
//  PaitientCell.swift
//  Demo
//
//  Created by Kondal Naidu on 18/07/23.
//

import UIKit

class PaitientCell: UITableViewCell {

    @IBOutlet weak var patientCollectionView: UICollectionView!
    var patientArr = ["new patient","Old Patient","Total Patient"]
    var admissionArr = ["Discharge","Admission","Occupancy"]

    var check_Flag = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.patientCollectionView.delegate = self
        self.patientCollectionView.dataSource = self
        patientCollectionView.register(UINib(nibName: "PatientCollectionCell", bundle: nil), forCellWithReuseIdentifier: "PatientCollectionCell")

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     }
    
}
extension PaitientCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.check_Flag == "patient" {
            return self.patientArr.count

        } else {
            return self.admissionArr.count

        }
         
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PatientCollectionCell", for: indexPath) as! PatientCollectionCell
        if self.check_Flag == "patient" {
            cell.titleLbl.text = self.patientArr[indexPath.row]

        } else {
            cell.titleLbl.text = self.admissionArr[indexPath.row]

        }
           return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.size.width / 3.5 +  10
        let height = collectionView.frame.size.height
            return CGSize(width: width, height: height)
        
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
   
}
