//
//  FinacialCell.swift
//  Demo
//
//  Created by Kondal Naidu on 18/07/23.
//

import UIKit

class FinacialCell: UITableViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var finacialCollectionView: UICollectionView!
   // var finanialArr = [DoctorHomeModel]()
    var finanialArr = ["Out Patient","In Patient","Pharmacy","Diagnostics","Total","Expenditure"]

    func getDataFromCell(summerArray:[DoctorHomeModel]) {
      //  finanialArr = summerArray
       // self.finacialCollectionView.reloadData()
    }
     override func awakeFromNib() {
        super.awakeFromNib()
        
         print("summer responce.........",finanialArr)
         finacialCollectionView.delegate = self
         finacialCollectionView.dataSource = self
         setupCollectionView()

     }
    
    func setupCollectionView() {
        finacialCollectionView.register(UINib(nibName: "FinacialCollectionCell", bundle: nil), forCellWithReuseIdentifier: "FinacialCollectionCell")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
     }
}
extension FinacialCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.finanialArr.count
         
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FinacialCollectionCell", for: indexPath) as! FinacialCollectionCell
        //let model = self.finanialArr[indexPath.row]
        cell.titleLbl.text = self.finanialArr[indexPath.row]
           return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
             let width = collectionView.frame.size.width / 2.5 + 30
            let height = collectionView.frame.size.height / 3.5
            return CGSize(width: width, height: height)
        
    }
//    func collectionView(_ collectionView: UIfCollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//           let padding: CGFloat =  50
//           let collectionViewSize = collectionView.frame.size.width - padding
//
//        return CGSize(width: collectionViewSize/2, height: collectionViewSize/3.5)
//       }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
   
}
