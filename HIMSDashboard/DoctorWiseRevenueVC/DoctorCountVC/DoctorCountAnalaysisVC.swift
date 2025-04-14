//
//  DoctorWiseRevenueVC.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 02/11/23.
//

import UIKit
import Charts
import DGCharts

class DoctorCountAnalaysisVC: UIViewController {
@IBOutlet weak var tableView: UITableView!
@IBOutlet weak var backBtn: UIButton!
var doctorwiseRevenueViewModel = DoctorwiseRevenueViewModel()
var doctorNamesArray = [AdmissionDoctorsModel]()//[String]()
var doctorReenueListArray = [DoctorRevenueModel]()
var appDelegate = UIApplication.shared.delegate as? AppDelegate
var datePicker:UIDatePicker = UIDatePicker()
var selectedDate = Date().getZeroTime()
    
let years = Array(1900...2030)
var basedOnSelectedFLd = 0
var baseUrl = ""
var type = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCell()
        appDelegate?.myOrientation = .landscape
        //self.doctorsNameAPi()
        
    }
private func setupCell() {
    self.tableView.register(UINib(nibName: StoryBoardIdentifiers.DoctorWiseRevenueCell, bundle: nil), forCellReuseIdentifier: StoryBoardIdentifiers.DoctorWiseRevenueCell)
    self.tableView.register(UINib(nibName: StoryBoardIdentifiers.RevenueMothWiseCell, bundle: nil), forCellReuseIdentifier: StoryBoardIdentifiers.RevenueMothWiseCell)//RevenueDetailMothlyCell
    self.tableView.register(UINib(nibName: StoryBoardIdentifiers.RevenueDetailMothlyCell, bundle: nil), forCellReuseIdentifier: StoryBoardIdentifiers.RevenueDetailMothlyCell)//RevenueDetailMothlyCell
    self.backBtn.setTitle("", for: .normal)
}
private func doctorsNameAPi() {
    self.doctorwiseRevenueViewModel.admissionDoctorsApi { responce in
        print("doctorsAPi", responce)
        self.doctorNamesArray = responce
        self.tableView.reloadData()
    } fail: { error in
        print("getting error")
    }
}
private func doctorsWiserevenueAPi(doctrId:Int, selectedYear:String, type: String) {
    self.baseUrl = UserDefaults.standard.value(forKey: "claint_Url") as! String
    let url = "\(self.baseUrl+Apis.doctorsRevenueApi)docId=\(doctrId)&Year=\(selectedYear)&Type=\(type)"
    doctorwiseRevenueViewModel.doctorwiseRevenueAPi(baseUrl: url) { responce in
        print(responce)
        self.doctorReenueListArray = responce
     } fail: { error in
        print("getting error")
    }

}
    
func setChart(values: [Int], barchatView:BarChartView) {
    barchatView.noDataText = "You need to provide data for the chart."
    //self.setPieChartColor(color: .white)
    var dataEntries: [BarChartDataEntry] = []
    for i in 0..<values.count {
        let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
        dataEntries.append(dataEntry)
    }
    let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Athen Tech")
    chartDataSet.colors = ChartColorTemplates.colorful()
    //        chartDataSet.colors = colorsOfCharts(numbersOfColor: values.count)
    let chartData = BarChartData(dataSet: chartDataSet)
    barchatView.data = chartData
    }
private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
    var colors: [UIColor] = []
    for _ in 0..<numbersOfColor {
        let red = Double(arc4random_uniform(256))
        let green = Double(arc4random_uniform(256))
        let blue = Double(arc4random_uniform(256))
        let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
        colors.append(color)
    }
    return colors
}
    
@IBAction func backActBtn(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
}
}
extension DoctorCountAnalaysisVC: UITableViewDelegate, UITableViewDataSource {
func numberOfSections(in tableView: UITableView) -> Int {
    return 3
}
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
        return 1
    } else if section == 1 {
        return 1
    } else {
        return 1
    }
}
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoardIdentifiers.DoctorWiseRevenueCell) as! DoctorWiseRevenueCell
        cell.allBtn.addTarget(self, action: #selector(allCheckActBtn), for: .touchUpInside)
        cell.opBtn.addTarget(self, action: #selector(allCheckActBtn), for: .touchUpInside)
        cell.ipbtn.addTarget(self, action: #selector(allCheckActBtn), for: .touchUpInside)
        cell.dpBtn.addTarget(self, action: #selector(allCheckActBtn), for: .touchUpInside)
        cell.pharmcyBtn.addTarget(self, action: #selector(allCheckActBtn), for: .touchUpInside)
        //  cell.yearFld.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
        setChart(values: [1,2,3,4,5,6,7], barchatView: cell.barchatView)
        cell.doctorNamesArray = self.doctorNamesArray
        return cell
        
    } else if indexPath.section == 1{
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoardIdentifiers.RevenueMothWiseCell) as! RevenueMothWiseCell
        return cell
        
    } else if indexPath.section == 2 {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoardIdentifiers.RevenueDetailMothlyCell) as! RevenueDetailMothlyCell
     //   let type = self.doctorReenueListArray[indexPath.row].tType
 
        if type == "Diag" {
         //   cell.diagonsticLbl.text = "\(self.doctorReenueListArray[indexPath.row].doctorRevenue?[0].january2023 ?? 0)"
         } else if type == "IP" {
            
        } else if type == "OP" {
            
        } else if type == "Pharmacy" {
            
        }
        return cell
    }
        return UITableViewCell()
    }
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
    if indexPath.section == 0 {
        return 250
    } else if indexPath.section == 1{
        return 40
    } else if indexPath.section == 2{
        return 500
    } else {
        return 0
    }
}
@objc func allCheckActBtn(sender: UIButton) {
    let index = IndexPath(row: 0, section: 0)
    let cell = tableView.cellForRow(at: index) as! DoctorWiseRevenueCell
    switch sender.tag {
    case 1:
        cell.allCheckImageView.image = UIImage(named: "check")
        cell.opCheckImageView.image = UIImage(named: "un_check")
        cell.ipCheckImageView.image = UIImage(named: "un_check")
        cell.dpCheckImageView.image = UIImage(named: "un_check")
        cell.pharmcyCheckImageView.image = UIImage(named: "un_check")
        self.type = "ALL"
    case 2:
        cell.allCheckImageView.image = UIImage(named: "un_check")
        cell.opCheckImageView.image = UIImage(named: "check")
        cell.ipCheckImageView.image = UIImage(named: "un_check")
        cell.dpCheckImageView.image = UIImage(named: "un_check")
        cell.pharmcyCheckImageView.image = UIImage(named: "un_check")
        self.type = "OP"
        
    case 3:
        cell.allCheckImageView.image = UIImage(named: "un_check")
        cell.opCheckImageView.image = UIImage(named: "un_check")
        cell.ipCheckImageView.image = UIImage(named: "check")
        cell.dpCheckImageView.image = UIImage(named: "un_check")
        cell.pharmcyCheckImageView.image = UIImage(named: "un_check")
        self.type = "IP"
        
    case 4:
        cell.allCheckImageView.image = UIImage(named: "un_check")
        cell.opCheckImageView.image = UIImage(named: "un_check")
        cell.ipCheckImageView.image = UIImage(named: "un_check")
        cell.dpCheckImageView.image = UIImage(named: "check")
        cell.pharmcyCheckImageView.image = UIImage(named: "un_check")
        self.type = "DP"
        
    case 5:
        cell.allCheckImageView.image = UIImage(named: "un_check")
        cell.opCheckImageView.image = UIImage(named: "un_check")
        cell.ipCheckImageView.image = UIImage(named: "un_check")
        cell.dpCheckImageView.image = UIImage(named: "un_check")
        cell.pharmcyCheckImageView.image = UIImage(named: "check")
        self.type = "PHARMACY"
        
        
    default:
        break
        }
        var doctrID = 0
        var year = cell.yearFld.text ?? ""
        let doctorName = cell.doctorNameField.text ?? ""
        for dict in self.doctorNamesArray {
            let name = dict.docName ?? ""
            if doctorName == name {
                doctrID = dict.docId ?? 0
            }
        }
        self.doctorsWiserevenueAPi(doctrId: doctrID, selectedYear: year, type: self.type)
     /*
    if sender.tag == 1 {
        if sender.isSelected == false {
            sender.isSelected = true
            cell.allCheckImageView.image = UIImage(named: "check")
        } else {
            sender.isSelected = false
            cell.allCheckImageView.image = UIImage(named: "un_check")
            
        }
    } else if sender.tag == 2 {
        if sender.isSelected == false {
            sender.isSelected = true
            cell.opCheckImageView.image = UIImage(named: "check")
        } else {
            sender.isSelected = false
            cell.opCheckImageView.image = UIImage(named: "un_check")
            
        }
    }  else if sender.tag == 3 {
        if sender.isSelected == false {
            sender.isSelected = true
            cell.ipCheckImageView.image = UIImage(named: "check")
        } else {
            sender.isSelected = false
            cell.ipCheckImageView.image = UIImage(named: "un_check")
            
        }
    } else if sender.tag == 4 {
        if sender.isSelected == false {
            sender.isSelected = true
            cell.dpCheckImageView.image = UIImage(named: "check")
        } else {
            sender.isSelected = false
            cell.dpCheckImageView.image = UIImage(named: "un_check")
            
        }
    } else if sender.tag == 5 {
        if sender.isSelected == false {
            sender.isSelected = true
            cell.pharmcyCheckImageView.image = UIImage(named: "check")
        } else {
            sender.isSelected = false
            cell.pharmcyCheckImageView.image = UIImage(named: "un_check")
            
        }
    }
     */
    }
//    @objc func doneButtonPressed() {
//        let index = IndexPath(row: 0, section: 0)
//        let cell = tableView.cellForRow(at: index) as! DoctorWiseRevenueCell
//         if let  datePicker = cell.doctorNameField.inputView as? UIPickerView {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "YYY-MM-dd"
//        }
//        self.selectedDate = datePicker.date.getZeroTime()
//        print("self.basedonSelectedTime", self.selectedDate )
//
//        cell.doctorNameField.resignFirstResponder()
//    }
//    private func setupPickerView(fld: UITextField) {
//        var pickerView = UIPickerView()
//        pickerView.delegate = self
//        pickerView.dataSource = self
//        // Assign the UIPickerView to the text field's inputView
//        fld.inputView = pickerView
//
//        // Add a toolbar with a Done button to dismiss the UIPickerView
//        let toolbar = UIToolbar()
//        toolbar.sizeToFit()
//
//        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
//        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
//        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        toolbar.setItems([doneButton, flexibleSpace, cancelBarButton], animated: true)
//
//        fld.inputAccessoryView = toolbar
//
//        // Set the text field delegate to handle user interactions
//        //fld.delegate = self
//    }
//    @objc func cancelPressed() {
//      self.resignFirstResponder()
//    }
}
