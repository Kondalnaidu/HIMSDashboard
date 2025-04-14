//
//  ExpendtureVC.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 14/11/23.
//

import UIKit

class ExpendtureVC: UIViewController {
    
@IBOutlet weak var dateFld: UITextField!
@IBOutlet weak var backBtn: UIButton!
@IBOutlet weak var countLbl: UILabel!
@IBOutlet weak var amountLbl: UILabel!
@IBOutlet weak var ttypLbl: UILabel!
@IBOutlet weak var bankAmountLbl: UILabel!
@IBOutlet weak var cachAmountLbl: UILabel!
@IBOutlet weak var bankView: UIView!
@IBOutlet weak var cashView: UIView!
@IBOutlet weak var nextBtn: UIButton!
@IBOutlet weak var previousBtn: UIButton!
@IBOutlet weak var dateView: UIView!
   
var expendutureViewModel = ExpendutureViewModel()
var selectedDate = Date().getZeroTime()
var datePicker:UIDatePicker = UIDatePicker()
    var claintAPi = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        self.design()
       // self.showIndicator()
        let swipeGestureRecognizerDown = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeGestureRecognizerDown.direction = .right
        self.view.addGestureRecognizer(swipeGestureRecognizerDown)
     }
    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
         case .right:
            self.navigationController?.popViewController(animated: true)
        default:
            break
        }

//        UIView.animate(withDuration: 0.25) {
//            self.swipeableView.frame = frame
        }
    
private func design() {
    self.backBtn.setTitle("", for: .normal)
    self.previousBtn.setTitle("", for: .normal)
    self.nextBtn.setTitle("", for: .normal)
    // self.cashView.roundCorners([.bottomLeft, .bottomRight, .topLeft, .topRight], radius: 10.0)
    self.cashView.clipsToBounds = true
    self.dateView.layer.cornerRadius = 4
    self.cashView.dropShadow()
    self.cashView.clipsToBounds = true
    self.cashView.layer.cornerRadius = 10
    
    self.bankView.dropShadow()
    self.bankView.clipsToBounds = true
    self.bankView.layer.cornerRadius = 10
    self.dateFld.text = getTimeFormate(date: self.selectedDate)
    
    dateFld.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
    
    
    self.expendutureAPi(date: self.getTimeFormate(date: self.selectedDate))
}
@objc func doneButtonPressed() {
    var currentDate = ""
    if let  datePicker = self.dateFld.inputView as? UIDatePicker {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "YYY/MM/dd"
        // dateFormatter.dateStyle = .medium
        self.dateFld.text = dateFormatter.string(from: datePicker.date)
        currentDate = self.dateFld.text ?? ""
    }
    self.selectedDate = datePicker.date.getZeroTime()
    print("self.basedonSelectedTime", self.selectedDate )
     self.showIndicator()
    self.expendutureAPi(date: currentDate)
    //self.opDetailAPi(url: Apis.opDetails, date: currentDate)
    //weeklySummerDetailsApi(claiantUrl: self.claintAPi, date: currentDate)
    self.dateFld.resignFirstResponder()
}
private func getTimeFormate(date: Date)-> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYY/MM/dd"
    let dateString = dateFormatter.string(from: date)
    return dateString
}
    
    
@IBAction func previousActBtn(_ sender: UIButton) {
    self.showIndicator()
    let cal = Calendar.current
    let date = cal.date(byAdding: .day, value: -1, to: self.selectedDate)
    self.selectedDate = date!.getZeroTime()
    dateFld.text = "\(getTimeFormate(date: self.selectedDate))"
    self.expendutureAPi(date: self.getTimeFormate(date: self.selectedDate))
    //self.opDetailAPi(url: Apis.opDetails, date: self.getTimeFormate(date: self.selectedDate))
    //weeklySummerDetailsApi(claiantUrl: self.claintAPi, date:self.getTimeFormate(date: self.selectedDate) )
}
@IBAction func nextActBtn(_ sender: UIButton) {
     self.showIndicator()
    let cal = Calendar.current
    let date = cal.date(byAdding: .day, value: 1, to: self.selectedDate)
    if date!.compare(Date()) == .orderedAscending {
        self.selectedDate = date!.getZeroTime()
    }
    dateFld.text = "\(getTimeFormate(date: self.selectedDate))"
    self.expendutureAPi(date: self.getTimeFormate(date: self.selectedDate))
    // self.showIndicator()
    //self.opDetailAPi(url: Apis.opDetails, date: self.getTimeFormate(date: self.selectedDate))
    //weeklySummerDetailsApi(claiantUrl: self.claintAPi, date:self.getTimeFormate(date: self.selectedDate) )
    print(getTimeFormate(date: self.selectedDate))
}
    
@IBAction func backActBtn(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
}
}
extension ExpendtureVC {
    private func expendutureAPi(date: String) {
        self.expendutureViewModel.expenditureApi(reportApi: Apis.expDetailsApi, baseUrl: self.claintAPi, selectedDate: date) { responce in
            print(responce)
            
            self.hideIndicator()
            
            var totSummaryArray = [ExpendutureTotSummary]()
            totSummaryArray.removeAll()
            var dtlsArray = [ExpendutureDtls]()//responce.dtls
            dtlsArray.removeAll()
            responce.dtls?.forEach({ ExpendutureDtls in
                dtlsArray.append(ExpendutureDtls)
            })
            responce.totSummary?.forEach({ ExpendutureTotSummary in
                totSummaryArray.append(ExpendutureTotSummary)
              })
            self.cachAmountLbl.text = "₹ \(totSummaryArray[0].aMT ?? 0)"
            self.bankAmountLbl.text = "₹ \(totSummaryArray[1].aMT ?? 0)"
            for dict in dtlsArray {
                self.ttypLbl.text = dict.tTYPE
                self.countLbl.text = "\(dict.cNT ?? 0)"
                self.amountLbl.text = "₹ \(dict.aMT ?? 0)"
            }
        } fail: { error in
            self.hideIndicator()
            print("getting errror")
        }

    }
}
