//
//  DoctorWiseRevenueVC.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 02/11/23.
//

import UIKit
import Charts
import DGCharts

class DoctorWiseRevenueVC: UIViewController, doctorwiseProtocol {
func getdataMothwise(docId:Int, Year: Int) {
 print("selecteddatafromcell")
}
@IBOutlet weak var haderlbl: UILabel!
@IBOutlet weak var tableView: UITableView!
@IBOutlet weak var backBtn: UIButton!
var selectedDate = Date().getZeroTime()
var datePicker:UIDatePicker = UIDatePicker()
var doctorwiseRevenueViewModel = DoctorwiseRevenueViewModel()
var appDelegate = UIApplication.shared.delegate as? AppDelegate
var doctorNamesArray = [AdmissionDoctorsModel]()//[String]()
lazy var years: [Int] = {
    let currentYear = Calendar.current.component(.year, from: Date())
    return Array((currentYear - 100)...currentYear).reversed() // Adjust the range as needed
}()
var doctorReenueListArray = [DoctorRevenueModel]()
var diagToatal = [Double]()
var outToatal = [Double]()
var inToatal = [Double]()
var pharmacyToatal = [Double]()
var weeklyGraphTotal = [Double]()
var comingFromSidemenuFlag = ""
var basedOnSelectedFLd = 0
var baseUrl = ""
var type = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCell()
        appDelegate?.myOrientation = .landscape
        self.doctorsNameAPi()
        if comingFromSidemenuFlag == "Doctor Wise Revenue" {
            self.haderlbl.text = "Doctor Wise Revenue"
        } else {
            self.haderlbl.text = "Doctor Count Analysis"

        }
}
private func setupCell() {
    self.tableView.register(UINib(nibName: StoryBoardIdentifiers.DoctorWiseRevenueCell, bundle: nil), forCellReuseIdentifier: StoryBoardIdentifiers.DoctorWiseRevenueCell)
    self.tableView.register(UINib(nibName: StoryBoardIdentifiers.RevenueMothWiseCell, bundle: nil), forCellReuseIdentifier: StoryBoardIdentifiers.RevenueMothWiseCell)//RevenueDetailMothlyCell
    self.tableView.register(UINib(nibName: StoryBoardIdentifiers.RevenueDetailMothlyCell, bundle: nil), forCellReuseIdentifier: StoryBoardIdentifiers.RevenueDetailMothlyCell)//RevenueDetailMothlyCell//RevenueTotalCell
    self.tableView.register(UINib(nibName:StoryBoardIdentifiers.RevenueTotalCell, bundle: nil), forCellReuseIdentifier: StoryBoardIdentifiers.RevenueTotalCell)

    self.backBtn.setTitle("", for: .normal)
}
private func doctorsNameAPi() {
    self.doctorwiseRevenueViewModel.admissionDoctorsApi { responce in
        print("doctorsAPi", responce)
        self.doctorNamesArray = responce
         DispatchQueue.main.async {
            self.tableView.reloadData()

        }
        
    } fail: { error in
        print("getting error")
    }

}
    private func grpahValues() {
        
        
        var type = ""
         if self.doctorReenueListArray.count > 0 {
            for dict in self.doctorReenueListArray{
                type   = dict.tType ?? ""
               
                if type == "Diag" {
                    
                  
                    diagToatal.append(Double(dict.doctorRevenue?[0].january2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].february2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].march2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].april2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].may2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].june2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].july2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].august2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].september2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].october2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].november2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].december2023 ?? 0))
                    
                    print("totalvalues:\(diagToatal)")
                    
                 } else if type == "IP" {
                      
                     
                     inToatal.append(Double(dict.doctorRevenue?[0].january2023 ?? 0))
                     inToatal.append(Double(dict.doctorRevenue?[0].february2023 ?? 0))
                     inToatal.append(Double(dict.doctorRevenue?[0].march2023 ?? 0))
                     inToatal.append(Double(dict.doctorRevenue?[0].april2023 ?? 0))
                     inToatal.append(Double(dict.doctorRevenue?[0].may2023 ?? 0))
                     inToatal.append(Double(dict.doctorRevenue?[0].june2023 ?? 0))
                     inToatal.append(Double(dict.doctorRevenue?[0].july2023 ?? 0))
                     inToatal.append(Double(dict.doctorRevenue?[0].august2023 ?? 0))
                     inToatal.append(Double(dict.doctorRevenue?[0].september2023 ?? 0))
                     inToatal.append(Double(dict.doctorRevenue?[0].october2023 ?? 0))
                     inToatal.append(Double(dict.doctorRevenue?[0].november2023 ?? 0))
                     inToatal.append(Double(dict.doctorRevenue?[0].december2023 ?? 0))
                     
                     
                } else if type == "OP" {
                     
                    outToatal.append(Double(dict.doctorRevenue?[0].january2023 ?? 0))
                    outToatal.append(Double(dict.doctorRevenue?[0].february2023 ?? 0))
                    outToatal.append(Double(dict.doctorRevenue?[0].march2023 ?? 0))
                    outToatal.append(Double(dict.doctorRevenue?[0].april2023 ?? 0))
                    outToatal.append(Double(dict.doctorRevenue?[0].may2023 ?? 0))
                    outToatal.append(Double(dict.doctorRevenue?[0].june2023 ?? 0))
                    outToatal.append(Double(dict.doctorRevenue?[0].july2023 ?? 0))
                    outToatal.append(Double(dict.doctorRevenue?[0].august2023 ?? 0))
                    outToatal.append(Double(dict.doctorRevenue?[0].september2023 ?? 0))
                    outToatal.append(Double(dict.doctorRevenue?[0].october2023 ?? 0))
                    outToatal.append(Double(dict.doctorRevenue?[0].november2023 ?? 0))
                    outToatal.append(Double(dict.doctorRevenue?[0].december2023 ?? 0))
                    
                    
                    
                } else if type == "Pharmacy" {
                    
                    pharmacyToatal.append(Double(dict.doctorRevenue?[0].january2023 ?? 0))
                    pharmacyToatal.append(Double(dict.doctorRevenue?[0].february2023 ?? 0))
                    pharmacyToatal.append(Double(dict.doctorRevenue?[0].march2023 ?? 0))
                    pharmacyToatal.append(Double(dict.doctorRevenue?[0].april2023 ?? 0))
                    pharmacyToatal.append(Double(dict.doctorRevenue?[0].may2023 ?? 0))
                    pharmacyToatal.append(Double(dict.doctorRevenue?[0].june2023 ?? 0))
                    pharmacyToatal.append(Double(dict.doctorRevenue?[0].july2023 ?? 0))
                    pharmacyToatal.append(Double(dict.doctorRevenue?[0].august2023 ?? 0))
                    pharmacyToatal.append(Double(dict.doctorRevenue?[0].september2023 ?? 0))
                    pharmacyToatal.append(Double(dict.doctorRevenue?[0].october2023 ?? 0))
                    pharmacyToatal.append(Double(dict.doctorRevenue?[0].november2023 ?? 0))
                    pharmacyToatal.append(Double(dict.doctorRevenue?[0].december2023 ?? 0))
                    
                }
                if type == "ALL" {
                    
                  
                    diagToatal.append(Double(dict.doctorRevenue?[0].january2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].february2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].march2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].april2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].may2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].june2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].july2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].august2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].september2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].october2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].november2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].december2023 ?? 0))
                    
                    print("totalvalues:\(diagToatal)")
                    
                    
                    pharmacyToatal.append(Double(dict.doctorRevenue?[0].january2023 ?? 0))
                    pharmacyToatal.append(Double(dict.doctorRevenue?[0].february2023 ?? 0))
                    pharmacyToatal.append(Double(dict.doctorRevenue?[0].march2023 ?? 0))
                    pharmacyToatal.append(Double(dict.doctorRevenue?[0].april2023 ?? 0))
                    pharmacyToatal.append(Double(dict.doctorRevenue?[0].may2023 ?? 0))
                    pharmacyToatal.append(Double(dict.doctorRevenue?[0].june2023 ?? 0))
                    pharmacyToatal.append(Double(dict.doctorRevenue?[0].july2023 ?? 0))
                    pharmacyToatal.append(Double(dict.doctorRevenue?[0].august2023 ?? 0))
                    pharmacyToatal.append(Double(dict.doctorRevenue?[0].september2023 ?? 0))
                    pharmacyToatal.append(Double(dict.doctorRevenue?[0].october2023 ?? 0))
                    pharmacyToatal.append(Double(dict.doctorRevenue?[0].november2023 ?? 0))
                    pharmacyToatal.append(Double(dict.doctorRevenue?[0].december2023 ?? 0))
                    
                    outToatal.append(Double(dict.doctorRevenue?[0].january2023 ?? 0))
                    outToatal.append(Double(dict.doctorRevenue?[0].february2023 ?? 0))
                    outToatal.append(Double(dict.doctorRevenue?[0].march2023 ?? 0))
                    outToatal.append(Double(dict.doctorRevenue?[0].april2023 ?? 0))
                    outToatal.append(Double(dict.doctorRevenue?[0].may2023 ?? 0))
                    outToatal.append(Double(dict.doctorRevenue?[0].june2023 ?? 0))
                    outToatal.append(Double(dict.doctorRevenue?[0].july2023 ?? 0))
                    outToatal.append(Double(dict.doctorRevenue?[0].august2023 ?? 0))
                    outToatal.append(Double(dict.doctorRevenue?[0].september2023 ?? 0))
                    outToatal.append(Double(dict.doctorRevenue?[0].october2023 ?? 0))
                    outToatal.append(Double(dict.doctorRevenue?[0].november2023 ?? 0))
                    outToatal.append(Double(dict.doctorRevenue?[0].december2023 ?? 0))
                    
                    inToatal.append(Double(dict.doctorRevenue?[0].january2023 ?? 0))
                    inToatal.append(Double(dict.doctorRevenue?[0].february2023 ?? 0))
                    inToatal.append(Double(dict.doctorRevenue?[0].march2023 ?? 0))
                    inToatal.append(Double(dict.doctorRevenue?[0].april2023 ?? 0))
                    inToatal.append(Double(dict.doctorRevenue?[0].may2023 ?? 0))
                    inToatal.append(Double(dict.doctorRevenue?[0].june2023 ?? 0))
                    inToatal.append(Double(dict.doctorRevenue?[0].july2023 ?? 0))
                    inToatal.append(Double(dict.doctorRevenue?[0].august2023 ?? 0))
                    inToatal.append(Double(dict.doctorRevenue?[0].september2023 ?? 0))
                    inToatal.append(Double(dict.doctorRevenue?[0].october2023 ?? 0))
                    inToatal.append(Double(dict.doctorRevenue?[0].november2023 ?? 0))
                    inToatal.append(Double(dict.doctorRevenue?[0].december2023 ?? 0))
                    
                    diagToatal.append(Double(dict.doctorRevenue?[0].january2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].february2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].march2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].april2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].may2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].june2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].july2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].august2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].september2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].october2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].november2023 ?? 0))
                    diagToatal.append(Double(dict.doctorRevenue?[0].december2023 ?? 0))
                    
                 }
               
                

            }
        }
       weeklyGraphTotal.append(outToatal.reduce(0,+))
       weeklyGraphTotal.append(inToatal.reduce(0,+))
       weeklyGraphTotal.append(diagToatal.reduce(0,+))
       weeklyGraphTotal.append(pharmacyToatal.reduce(0,+))
       
        print(weeklyGraphTotal)
        
  }
private func doctorsWiserevenueAPi(doctrId:Int, selectedYear:String, type: String) {
    self.baseUrl = UserDefaults.standard.value(forKey: "claint_Url") as! String
    var url = ""
    if comingFromSidemenuFlag == "Doctor Wise Revenue" {
         url = "\(self.baseUrl+Apis.doctorsRevenueApi)docId=\(doctrId)&Year=\(selectedYear)&Type=\(type)"
    } else {
        url = "\(self.baseUrl+Apis.DoctorwiseCount)docId=\(doctrId)&Year=\(selectedYear)&Type=\(type)"
    }
    print(url)
    doctorwiseRevenueViewModel.doctorwiseRevenueAPi(baseUrl: url) { responce in
        print(responce)
        self.doctorReenueListArray.removeAll()
        self.weeklyGraphTotal.removeAll()
        self.inToatal.removeAll()
        self.outToatal.removeAll()
        self.diagToatal.removeAll()
        self.pharmacyToatal.removeAll()
        self.doctorReenueListArray = responce
         DispatchQueue.main.async {
            self.tableView.reloadData()

        }
        self.grpahValues()
       
     } fail: { error in
        print("getting error")
    }

}
func setChart(values: [Double], barchatView:BarChartView) {
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
extension DoctorWiseRevenueVC: UITableViewDelegate, UITableViewDataSource {
func numberOfSections(in tableView: UITableView) -> Int {
    return 4
}
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
        return 1
    } else if section == 1 {
        return 1
    } else if section == 2{
        return 1
    } else {
        return 1
    }
}
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorWiseRevenueCell") as! DoctorWiseRevenueCell
        cell.allBtn.addTarget(self, action: #selector(allCheckActBtn), for: .touchUpInside)
        cell.opBtn.addTarget(self, action: #selector(allCheckActBtn), for: .touchUpInside)
        cell.ipbtn.addTarget(self, action: #selector(allCheckActBtn), for: .touchUpInside)
        cell.dpBtn.addTarget(self, action: #selector(allCheckActBtn), for: .touchUpInside)
        cell.pharmcyBtn.addTarget(self, action: #selector(allCheckActBtn), for: .touchUpInside)
        //  cell.yearFld.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
        cell.doctorNamesArray = self.doctorNamesArray
        setChart(values: self.weeklyGraphTotal, barchatView: cell.barchatView)
         cell.delegate = self
 
        return cell
        
    }
    else if indexPath.section == 1{
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoardIdentifiers.RevenueMothWiseCell) as! RevenueMothWiseCell
        return cell
        
    } else if indexPath.section == 2{
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoardIdentifiers.RevenueDetailMothlyCell) as! RevenueDetailMothlyCell
        var type = ""
         if self.doctorReenueListArray.count > 0 {
            for dict in self.doctorReenueListArray{
                type   = dict.tType ?? ""
               
                if type == "Diag" {
                    cell.janDiaogonosticLbl.text = "\(dict.doctorRevenue?[0].january2023 ?? 0)"
                    cell.febDiagonosticLbl.text = "\(dict.doctorRevenue?[0].february2023 ?? 0)"
                    cell.marchDiagonosticLbl.text = "\(dict.doctorRevenue?[0].march2023 ?? 0)"
                    cell.aprilDiagonosticLbl.text = "\(dict.doctorRevenue?[0].april2023 ?? 0)"
                    cell.mayDiagonosticLbl.text = "\(dict.doctorRevenue?[0].may2023 ?? 0)"
                    cell.junDiagonosticLbl.text = "\(dict.doctorRevenue?[0].june2023 ?? 0)"
                    cell.julyDiagonosticLbl.text = "\(dict.doctorRevenue?[0].july2023 ?? 0)"
                    cell.augDiagonosticLbl.text = "\(dict.doctorRevenue?[0].august2023 ?? 0)"
                    cell.sepDiagonosticLbl.text = "\(dict.doctorRevenue?[0].september2023 ?? 0)"
                    cell.octDiagonosticLbl.text = "\(dict.doctorRevenue?[0].october2023 ?? 0)"
                    cell.novDiagonosticLbl.text = "\(dict.doctorRevenue?[0].november2023 ?? 0)"
                    cell.decDiagonosticLbl.text = "\(dict.doctorRevenue?[0].december2023 ?? 0)"
                  
//                    diagToatal.append(dict.doctorRevenue?[0].january2023 ?? 0)
//                    diagToatal.append(dict.doctorRevenue?[0].february2023 ?? 0)
//                    diagToatal.append(dict.doctorRevenue?[0].march2023 ?? 0)
//                    diagToatal.append(dict.doctorRevenue?[0].april2023 ?? 0)
//                    diagToatal.append(dict.doctorRevenue?[0].may2023 ?? 0)
//                    diagToatal.append(dict.doctorRevenue?[0].june2023 ?? 0)
//                    diagToatal.append(dict.doctorRevenue?[0].july2023 ?? 0)
//                    diagToatal.append(dict.doctorRevenue?[0].august2023 ?? 0)
//                    diagToatal.append(dict.doctorRevenue?[0].september2023 ?? 0)
//                    diagToatal.append(dict.doctorRevenue?[0].october2023 ?? 0)
//                    diagToatal.append(dict.doctorRevenue?[0].november2023 ?? 0)
//                    diagToatal.append(dict.doctorRevenue?[0].december2023 ?? 0)
                    
                    print("totalvalues:\(diagToatal)")
                    
                 } else if type == "IP" {
                      cell.janInLbl.text = "\(dict.doctorRevenue?[0].january2023 ?? 0)"
                     cell.febInLbl.text = "\(dict.doctorRevenue?[0].february2023 ?? 0)"
                     cell.marchInLbl.text = "\(dict.doctorRevenue?[0].march2023 ?? 0)"
                     cell.aprilInLbl.text = "\(dict.doctorRevenue?[0].april2023 ?? 0)"
                     cell.mayInLbl.text = "\(dict.doctorRevenue?[0].may2023 ?? 0)"
                     cell.junInLbl.text = "\(dict.doctorRevenue?[0].june2023 ?? 0)"
                     cell.julyInLbl.text = "\(dict.doctorRevenue?[0].july2023 ?? 0)"
                     cell.augInLbl.text = "\(dict.doctorRevenue?[0].august2023 ?? 0)"
                     cell.sepInLbl.text = "\(dict.doctorRevenue?[0].september2023 ?? 0)"
                     cell.octInLbl.text = "\(dict.doctorRevenue?[0].october2023 ?? 0)"
                     cell.novInLbl.text = "\(dict.doctorRevenue?[0].november2023 ?? 0)"
                     cell.decInLbl.text = "\(dict.doctorRevenue?[0].december2023 ?? 0)"
                     
//                     inToatal.append(dict.doctorRevenue?[0].january2023 ?? 0)
//                     inToatal.append(dict.doctorRevenue?[0].february2023 ?? 0)
//                     inToatal.append(dict.doctorRevenue?[0].march2023 ?? 0)
//                     inToatal.append(dict.doctorRevenue?[0].april2023 ?? 0)
//                     inToatal.append(dict.doctorRevenue?[0].may2023 ?? 0)
//                     inToatal.append(dict.doctorRevenue?[0].june2023 ?? 0)
//                     inToatal.append(dict.doctorRevenue?[0].july2023 ?? 0)
//                     inToatal.append(dict.doctorRevenue?[0].august2023 ?? 0)
//                     inToatal.append(dict.doctorRevenue?[0].september2023 ?? 0)
//                     inToatal.append(dict.doctorRevenue?[0].october2023 ?? 0)
//                     inToatal.append(dict.doctorRevenue?[0].november2023 ?? 0)
//                     inToatal.append(dict.doctorRevenue?[0].december2023 ?? 0)
                     
                     
                } else if type == "OP" {
                     cell.janOutLbl.text = "\(dict.doctorRevenue?[0].january2023 ?? 0)"
                    cell.febOutLbl.text = "\(dict.doctorRevenue?[0].february2023 ?? 0)"
                    cell.marchOutLbl.text = "\(dict.doctorRevenue?[0].march2023 ?? 0)"
                    cell.aprilOutLbl.text = "\(dict.doctorRevenue?[0].april2023 ?? 0)"
                    cell.mayOutLbl.text = "\(dict.doctorRevenue?[0].may2023 ?? 0)"
                    cell.junOutLbl.text = "\(dict.doctorRevenue?[0].june2023 ?? 0)"
                    cell.julyOutLbl.text = "\(dict.doctorRevenue?[0].july2023 ?? 0)"
                    cell.augOutLbl.text = "\(dict.doctorRevenue?[0].august2023 ?? 0)"
                    cell.sepOutLbl.text = "\(dict.doctorRevenue?[0].september2023 ?? 0)"
                    cell.octOutLbl.text = "\(dict.doctorRevenue?[0].october2023 ?? 0)"
                    cell.novOutLbl.text = "\(dict.doctorRevenue?[0].november2023 ?? 0)"
                    cell.decOutLbl.text = "\(dict.doctorRevenue?[0].december2023 ?? 0)"
                    
                    
//                    outToatal.append(dict.doctorRevenue?[0].january2023 ?? 0)
//                    outToatal.append(dict.doctorRevenue?[0].february2023 ?? 0)
//                    outToatal.append(dict.doctorRevenue?[0].march2023 ?? 0)
//                    outToatal.append(dict.doctorRevenue?[0].april2023 ?? 0)
//                    outToatal.append(dict.doctorRevenue?[0].may2023 ?? 0)
//                    outToatal.append(dict.doctorRevenue?[0].june2023 ?? 0)
//                    outToatal.append(dict.doctorRevenue?[0].july2023 ?? 0)
//                    outToatal.append(dict.doctorRevenue?[0].august2023 ?? 0)
//                    outToatal.append(dict.doctorRevenue?[0].september2023 ?? 0)
//                    outToatal.append(dict.doctorRevenue?[0].october2023 ?? 0)
//                    outToatal.append(dict.doctorRevenue?[0].november2023 ?? 0)
//                    outToatal.append(dict.doctorRevenue?[0].december2023 ?? 0)
                    
                } else if type == "Pharmacy" {
                    cell.janPharmcyLbl.text = "\(dict.doctorRevenue?[0].january2023 ?? 0)"
                    cell.febPharmacyLbl.text = "\(dict.doctorRevenue?[0].february2023 ?? 0)"
                    cell.marchPharmacyLbl.text = "\(dict.doctorRevenue?[0].march2023 ?? 0)"
                    cell.aprilPharmacyLbl.text = "\(dict.doctorRevenue?[0].april2023 ?? 0)"
                    cell.mayPharmacyLbl.text = "\(dict.doctorRevenue?[0].may2023 ?? 0)"
                    cell.junePharmacylbl.text = "\(dict.doctorRevenue?[0].june2023 ?? 0)"
                    cell.julyPharmacyLbl.text = "\(dict.doctorRevenue?[0].july2023 ?? 0)"
                    cell.augPharmacyLbl.text = "\(dict.doctorRevenue?[0].august2023 ?? 0)"
                    cell.sepPharmacyLbl.text = "\(dict.doctorRevenue?[0].september2023 ?? 0)"
                    cell.octPharamcyLbl.text = "\(dict.doctorRevenue?[0].october2023 ?? 0)"
                    cell.novPharmacyLbl.text = "\(dict.doctorRevenue?[0].november2023 ?? 0)"
                    cell.decPharmacyLbl.text = "\(dict.doctorRevenue?[0].december2023 ?? 0)"
                    
//                    pharmacyToatal.append(dict.doctorRevenue?[0].january2023 ?? 0)
//                    pharmacyToatal.append(dict.doctorRevenue?[0].february2023 ?? 0)
//                    pharmacyToatal.append(dict.doctorRevenue?[0].march2023 ?? 0)
//                    pharmacyToatal.append(dict.doctorRevenue?[0].april2023 ?? 0)
//                    pharmacyToatal.append(dict.doctorRevenue?[0].may2023 ?? 0)
//                    pharmacyToatal.append(dict.doctorRevenue?[0].june2023 ?? 0)
//                    pharmacyToatal.append(dict.doctorRevenue?[0].july2023 ?? 0)
//                    pharmacyToatal.append(dict.doctorRevenue?[0].august2023 ?? 0)
//                    pharmacyToatal.append(dict.doctorRevenue?[0].september2023 ?? 0)
//                    pharmacyToatal.append(dict.doctorRevenue?[0].october2023 ?? 0)
//                    pharmacyToatal.append(dict.doctorRevenue?[0].november2023 ?? 0)
//                    pharmacyToatal.append(dict.doctorRevenue?[0].december2023 ?? 0)
                    
                }
            }
        }
        return cell
    } else if indexPath.section == 3{
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoardIdentifiers.RevenueTotalCell) as! RevenueTotalCell
        cell.diagonoTotalLvl.text = "\(diagToatal.reduce(0, +))"
        cell.intotalLbl.text = "\(inToatal.reduce(0, +))"
        cell.outTotalLbl.text = "\(outToatal.reduce(0, +))"
        cell.pharmcyTotalbl.text = "\(pharmacyToatal.reduce(0, +))"
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
            return 50
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
            self.type = "Diag"
            
        case 5:
            cell.allCheckImageView.image = UIImage(named: "un_check")
            cell.opCheckImageView.image = UIImage(named: "un_check")
            cell.ipCheckImageView.image = UIImage(named: "un_check")
            cell.dpCheckImageView.image = UIImage(named: "un_check")
            cell.pharmcyCheckImageView.image = UIImage(named: "check")
            self.type = "Pharmacy"
            
            
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
        
     
    }
 
}
