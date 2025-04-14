//
//  DoctorHomeVc.swift
//  Demo
//
//  Created by Kondal Naidu on 18/07/23.
//

import UIKit
import Charts
import DGCharts
import FSCalendar
class DoctorHomeVc: UIViewController {
@IBOutlet weak var mainView: UIView!
@IBOutlet weak var homeTableView: UITableView!
@IBOutlet weak var calender: FSCalendar!
    
var Leads = ["1.30","2.30","4.30","5.30","6.30","7.20","8.10"]
var dates = ["1.00","2.00","4.00","5.00","6.00","7.00","8.50"]
var finanialArr = ["Out Patient","In Patient","Pharmacy","Diagnostics","Total","Expenditure"]
var patientArr = ["new patient","Old Patient","Total Patient"]
var admissionArr = ["Discharge","Admission","Occupancy"]
var selectedDate = Date().getZeroTime()
var doctorViewModel = DoctorViewModel()
var summerListArray = [DoctorHomeModel]()
var claintAPi = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCell()
        setMinimumDateInCalender()
        self.showIndicator()
        summerApiCall(claiantUrl: self.claintAPi, date: "2023/08/12")
        print(claintAPi)
        self.homeTableView.delegate = self
        self.homeTableView.dataSource = self
        
 }
    
func setupCell() {
    homeTableView.register(UINib(nibName: "GraphCell", bundle: nil), forCellReuseIdentifier: "GraphCell")
    homeTableView.register(UINib(nibName: "FinacialCell", bundle: nil), forCellReuseIdentifier: "FinacialCell")
    homeTableView.register(UINib(nibName: "PaitientCell", bundle: nil), forCellReuseIdentifier: "PaitientCell")
    self.mainView.isHidden = true
    self.mainView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
    
   // self.homeTableView.reloadData()
    let indexPath = IndexPath(row: 0, section: 0)
    if let cell = self.homeTableView.cellForRow(at: indexPath) as? GraphCell {
        cell.datelbl.text = "\(Date.getCurrentDate())"
    }
}
    private func summerApiCall(claiantUrl:String,date: String) {
        self.doctorViewModel.homeScreensummmerApi(baseUrl: claiantUrl, selectedDate: date) { responce in
            print("home screen summer responce", responce)
            self.hideIndicator()
            self.summerListArray = responce
            print(self.summerListArray)
            DispatchQueue.main.async {
                self.homeTableView.reloadData()
            }
        } fail: { error in
            print("getting error")
        }

    }
 
private func setMinimumDateInCalender() {
        self.calender.delegate = self
}
override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(false, animated: animated)
}
}
extension DoctorHomeVc: UITableViewDelegate, UITableViewDataSource {
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 4
}
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GraphCell") as! GraphCell
        cell.calenderBtn.addTarget(self, action: #selector(calenderActBtn), for: .touchUpInside)
        cell.rightArrowBtn.addTarget(self, action: #selector(nextDateActBtn), for: .touchUpInside)
        cell.leftArrowBtn.addTarget(self, action: #selector(previousDateActBtn), for: .touchUpInside)
        setBarchat(barchatView: cell.barchatiew)
        return cell
    } else if indexPath.row == 1 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FinacialCell") as! FinacialCell
       // cell.getDataFromCell(summerArray: summerListArray)
           return cell
    } else if indexPath.row == 2{
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaitientCell") as! PaitientCell
        cell.check_Flag = "patient"
        return cell
    } else if indexPath.row == 3 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaitientCell") as! PaitientCell
        cell.check_Flag = "admission"
        return cell
    } else {
        return UITableViewCell()
    }
}
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.row == 0 {
        return 320
    } else if indexPath.row == 1 {
        return 250
    } else if indexPath.row == 2 || indexPath.row == 3 {
        return 100
    }
    else {
        return 0
    }
}
func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 10
}
    
func setBarchat(barchatView:BarChartView) {
    var entrys = [BarChartDataEntry]()
    for x in 0..<7 {
        entrys.append(BarChartDataEntry(x: Double(x), y: Double(x)))
    }
    let set = BarChartDataSet(entries: entrys)
    set.colors = ChartColorTemplates.colorful()
    
    let data = BarChartData(dataSet: set)
    barchatView.data = data
    
    //barchatView.xAxis.axisLineWidth = 10
    // barchatView.xAxis.labelTextColor = UIColor.white
    //barchatView.xAxis.axisLineColor = UIColor.red
 }
@objc private func calenderActBtn(sender: UIButton) {
    UIView.transition(with: self.mainView,
                      duration: 0.5,
                      options: [.transitionFlipFromRight],
                      animations: {
        
        self.mainView.isHidden = false
    },
                      completion: nil)
    }
override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    self.mainView.isHidden = true
}
}
 
extension DoctorHomeVc: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let result = formatter.string(from: date)
        print(result)
    }
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    func calendar(_ calendar: FSCalendar, willDisplay cell: FSCalendarCell, for date: Date, at monthPosition: FSCalendarMonthPosition) {
    }
}
extension DoctorHomeVc {
    @objc private func nextDateActBtn() {
        
        let cal = Calendar.current
        let date = cal.date(byAdding: .day, value: 1, to: self.selectedDate)
        if date!.compare(Date()) == .orderedAscending {
            self.selectedDate = date!.getZeroTime()
         }
        let indexPath = IndexPath(row: 0, section: 0)
         
        if let cell = self.homeTableView.cellForRow(at: indexPath) as? GraphCell {
            
            cell.datelbl.text = "\(getTimeFormate(date: self.selectedDate))"
        }
        print(getTimeFormate(date: self.selectedDate))
        
    }
@objc private func previousDateActBtn() {
    let cal = Calendar.current
    let date = cal.date(byAdding: .day, value: -1, to: self.selectedDate)
    self.selectedDate = date!.getZeroTime()
    // print(calender.setCurrentPage(getPreviousMonth(date: calender.currentPage), animated: true))
    let indexPath = IndexPath(row: 0, section: 0)
    if let cell = self.homeTableView.cellForRow(at: indexPath) as? GraphCell {
        cell.datelbl.text = "\(getTimeFormate(date: self.selectedDate))"
    }
}
func getNextMonth(date:Date)->Date {
    return  Calendar.current.date(byAdding: .month, value: 1, to:date)!
}
func getPreviousMonth(date:Date)->Date {
    return  Calendar.current.date(byAdding: .month, value: -1, to:date)!
}
private func getTimeFormate(date: Date)-> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYY-MM-dd"
    let dateString = dateFormatter.string(from: date)
    return dateString
}
}
extension Date {
 static func getCurrentDate() -> String {
     let dateFormatter = DateFormatter()
     dateFormatter.dateFormat = "yyyy-MM-dd"
     return dateFormatter.string(from: Date())
     
 }
}
