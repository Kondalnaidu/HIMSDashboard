//
//  DischargeDetailVC.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 02/11/23.
//
import UIKit
import DGCharts
import Charts
class DischargeDetailVC: UIViewController {
    @IBOutlet weak var rightArrowBtn: UIButton!
    @IBOutlet weak var leftArrowBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var rotateBtn: UIButton!
    @IBOutlet weak var dateView: UIView!
    @IBOutlet weak var barChatView: BarChartView!
    @IBOutlet weak var dischargeCountLbl: UILabel!
    @IBOutlet weak var disChargeTypeLbl: UILabel!
    @IBOutlet weak var admissionCountlbl: UILabel!
    @IBOutlet weak var admissionTypelbl: UILabel!
    @IBOutlet weak var currentOccupancyTypeLbl: UILabel!
    @IBOutlet weak var currentOccupancyCountLbl: UILabel!
    @IBOutlet weak var dateFld: UITextField!
    @IBOutlet weak var dischargeBtn: UIButton!
    @IBOutlet weak var occupancyBtn: UIButton!
    @IBOutlet weak var admissionBtn: UIButton!
    @IBOutlet weak var dischargeDetailLbl: UILabel!
    @IBOutlet weak var barView: UIView!
    
    var datePicker:UIDatePicker = UIDatePicker()
    var selectedDate = Date().getZeroTime()
    var dischargeViewModel = DischargeViewModel()
    var weekwiseArray = [AdmissionDischargeDetailsWeekModel]()
    var weeklyDetalsArray = [Int]()
    var clickFrom = ""
    var claintAPi = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = UIView()
        view.overrideUserInterfaceStyle = .dark
        design()
        //  self.setChart(values: [1,2,3,4,5,6,7], barchatView: self.barChatView)
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
}
private func design() {
    self.dateView.layer.cornerRadius = 4
    self.dateView.clipsToBounds = true
    self.leftArrowBtn.setTitle("", for: .normal)
    self.rightArrowBtn.setTitle("", for: .normal)
    self.rotateBtn.setTitle("", for: .normal)
    self.backBtn.setTitle("", for: .normal)
    self.occupancyBtn.setTitle("", for: .normal)
    self.dischargeBtn.setTitle("", for: .normal)
    self.admissionBtn.setTitle("", for: .normal)
    
    self.barView.layer.cornerRadius = 4
    self.barView.clipsToBounds = true
    
    dateFld.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
    self.dateFld.text = getTimeFormate(date: self.selectedDate)
    
    self.showIndicator()
    self.setupBarChart()
    
    self.dischargeDetailApi(date: self.getTimeFormate(date: self.selectedDate))
    //  weeklySummerDetailsApi(claiantUrl: self.claintAPi, date:self.getTimeFormate(date: self.selectedDate) )
    self.setHeaderTitle(str: self.clickFrom)
    self.AdmissionDischargeWeekwise(date: self.getTimeFormate(date: self.selectedDate))
}
    private func setHeaderTitle(str: String) {
        if str == "Occupancy" {
            self.dischargeDetailLbl.text = "Occupancy"
            
        } else if str == "Admission" {
            self.dischargeDetailLbl.text = "Admission"
            
        } else if str == "Discharge" {
            self.dischargeDetailLbl.text = "Discharge"
            
        }
}
@objc func doneButtonPressed() {
    var currentDate = ""
        if let  datePicker = self.dateFld.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = "YYY-MM-dd"
            // dateFormatter.dateStyle = .medium
            self.dateFld.text = dateFormatter.string(from: datePicker.date)
            currentDate = self.dateFld.text ?? ""
        }
        self.selectedDate = datePicker.date.getZeroTime()
        print("self.basedonSelectedTime", self.selectedDate )
        self.showIndicator()
        self.dischargeDetailApi(date: currentDate)
        //weeklySummerDetailsApi(claiantUrl: self.claintAPi, date: currentDate)
    self.AdmissionDischargeWeekwise(date: currentDate)

        //self.opDetailAPi(url: Apis.opDetails, date: currentDate)
       // weeklySummerDetailsApi(claiantUrl: self.claintAPi, date: currentDate)
        self.dateFld.resignFirstResponder()
    }
    
    func setupBarChart() {
            // Sample data
            let entries1: [BarChartDataEntry] = [BarChartDataEntry(x: 0, y: 5), BarChartDataEntry(x: 1, y: 8), BarChartDataEntry(x: 2, y: 6)]
            let entries2: [BarChartDataEntry] = [BarChartDataEntry(x: 0, y: 7), BarChartDataEntry(x: 1, y: 4), BarChartDataEntry(x: 2, y: 3)]

            // Create datasets
            let dataSet1 = BarChartDataSet(entries: entries1, label: "DataSet 1")
            let dataSet2 = BarChartDataSet(entries: entries2, label: "DataSet 2")

            // Customize dataset properties (colors, etc.) if needed
            dataSet1.colors = [NSUIColor.blue]
            dataSet2.colors = [NSUIColor.green]

            // Create a BarChartData object with datasets
            let data = BarChartData(dataSets: [dataSet1, dataSet2])

            // Bar width configuration (if needed)
            let barWidth = 0.4
            data.barWidth = barWidth

            // Group spacing configuration (if needed)
            let groupSpace = 0.1
            let barSpace = 0.02
            data.groupBars(fromX: 0, groupSpace: groupSpace, barSpace: barSpace)

            // Set the data to the chart view
        barChatView.data = data

            // Optional: Customize the chart appearance
        barChatView.chartDescription.text = "Grouped Bar Chart"
            barChatView.animate(yAxisDuration: 1.5, easingOption: .easeInOutQuart)
        }

    

    func setChart(firstValue: [Int],secondValues: [Int], barchatView:BarChartView) {
    barchatView.noDataText = "You need to provide data for the chart."
    //self.setPieChartColor(color: .white)
    var dataEntries: [BarChartDataEntry] = []
    for i in 0..<firstValue.count {
        let dataEntry = BarChartDataEntry(x: Double(i), y: Double(firstValue[i]))
        dataEntries.append(dataEntry)
    }
    var dataEntriesSecond: [BarChartDataEntry] = []

    for i in 0..<secondValues.count {
        let dataEntrySecond = BarChartDataEntry(x: Double(i), y: Double(secondValues[i]))
        dataEntriesSecond.append(dataEntrySecond)
    }
    let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Discharge")
    let chartDataSetSecond = BarChartDataSet(entries: dataEntriesSecond, label: "Admission")

    // chartDataSet.colors = ChartColorTemplates.colorful()
        chartDataSet.colors = [NSUIColor.blue]//colorsOfCharts(numbersOfColor: firstValue.count)
        chartDataSetSecond.colors = [NSUIColor.green]//colorsOfCharts(numbersOfColor: secondValues.count)

        let data = BarChartData(dataSets: [chartDataSet, chartDataSetSecond])
        let barWidth = 0.4
        data.barWidth = barWidth

        // Group spacing configuration (if needed)
        let groupSpace = 0.1
        let barSpace = 0.02
        data.groupBars(fromX: 0, groupSpace: groupSpace, barSpace: barSpace)

        // Set the data to the chart view
    barChatView.data = data

        // Optional: Customize the chart appearance
    barChatView.chartDescription.text = "Grouped Bar Chart"
        barChatView.animate(yAxisDuration: 1.5, easingOption: .easeInOutQuart)
   // let chartData = BarChartData(dataSet: [chartDataSet, chartDataSetSecond])
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
@IBAction func occupancyActBtn(_ sender: UIButton) {
    let vc = self.storyboard?.instantiateViewController(withIdentifier: StoryBoardIdentifiers.PdfVC) as! PdfVC
    if sender.tag == 1 {
        vc.clickFrom = AdmissionDischargeValidationkeys.Occupancy//Discharge
    } else if sender.tag == 2 {
        vc.clickFrom = AdmissionDischargeValidationkeys.Admission//Admission

    } else {
        vc.clickFrom = AdmissionDischargeValidationkeys.Discharge//Occupancy
    }
    vc.claintAPi = self.claintAPi
    vc.selectedDate = self.dateFld.text ?? ""
    self.navigationController?.pushViewController(vc, animated: true)
}
private func getTimeFormate(date: Date)-> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYY-MM-dd"
    let dateString = dateFormatter.string(from: date)
    return dateString
}
@IBAction func previousDateActBtn(_ sender: UIButton) {
    let cal = Calendar.current
    let date = cal.date(byAdding: .day, value: -1, to: self.selectedDate)
    self.selectedDate = date!.getZeroTime()
    dateFld.text = "\(getTimeFormate(date: self.selectedDate))"
    self.dischargeDetailApi(date: self.getTimeFormate(date: self.selectedDate))
    //weeklySummerDetailsApi(claiantUrl: self.claintAPi, date:self.getTimeFormate(date: self.selectedDate) )
    self.AdmissionDischargeWeekwise(date: self.getTimeFormate(date: self.selectedDate))
}
    
@IBAction func nextDateActBtn(_ sender: UIButton) {
    let cal = Calendar.current
    let date = cal.date(byAdding: .day, value: 1, to: self.selectedDate)
    if date!.compare(Date()) == .orderedAscending {
        self.selectedDate = date!.getZeroTime()
    }
    dateFld.text = "\(getTimeFormate(date: self.selectedDate))"
    self.showIndicator()
    self.dischargeDetailApi(date: self.getTimeFormate(date: self.selectedDate))
   // weeklySummerDetailsApi(claiantUrl: self.claintAPi, date:self.getTimeFormate(date: self.selectedDate) )
    self.AdmissionDischargeWeekwise(date: self.getTimeFormate(date: self.selectedDate))

}
}
extension DischargeDetailVC {
private func dischargeDetailApi(date:String) {
    self.dischargeViewModel.dischargeApi(mainUrl: self.claintAPi, selectedDate: date) { responce in
        self.hideIndicator()
        print(responce)
        var listArray = [DischargeModel]()
        for dict in responce {
            self.currentOccupancyCountLbl.text = "\(dict.bedCnt ?? 0)"
            self.admissionCountlbl.text = "\(dict.admnCnt ?? 0)"
            self.dischargeCountLbl.text = "\(dict.dischrgeCnt ?? 0)"
        }
    } fail: { error in
        print("getting errror")
    }
    
}
private func AdmissionDischargeWeekwise(date:String) {
    self.dischargeViewModel.dischargeWeekWiseApi(mainUrl: self.claintAPi, selectedDate: date) { responce in
        self.hideIndicator()
        print(responce)
        self.weekwiseArray.removeAll()
        var listArray = [AdmissionDischargeDetailsWeekModel]()
        self.weekwiseArray = responce
        var admissionArray = [Int]()
        var dischargeArray = [Int]()
        for dict in self.weekwiseArray {
            admissionArray.append(dict.admnCnt ?? 0)
            dischargeArray.append(dict.dischrgeCnt ?? 0)
        }
        self.setChart(firstValue: admissionArray, secondValues: dischargeArray, barchatView: self.barChatView)
        print(self.weekwiseArray)
        
    } fail: { error in
        print("getting errror")
    }
}
func setChart(values: [Int]) {
    barChatView.noDataText = "You need to provide data for the chart."
    //self.setPieChartColor(color: .white)
    var dataEntries: [BarChartDataEntry] = []
    for i in 0..<values.count {
        let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
        dataEntries.append(dataEntry)
    }
    let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Athen Tech")
    chartDataSet.colors = ChartColorTemplates.colorful()
    //chartDataSet.colors = colorsOfCharts(numbersOfColor: values.count)
    let chartData = BarChartData(dataSet: chartDataSet)
    barChatView.data = chartData
    }
private func weeklySummerDetailsApi(claiantUrl:String,date: String) {
    self.dischargeViewModel.dashBoardAWeekSummerAPi(baseUrl: claiantUrl, selectedDate: date) { responce in
        print("Weekly patent responce", responce)
        self.hideIndicator()
        self.weeklyDetalsArray.removeAll()
        for dict in responce {
            self.weeklyDetalsArray.append(dict.total ?? 0)
        }
        //self.setBarchat(barchatView: self.barChatView)
        self.setChart(values: self.weeklyDetalsArray)
        //  self.setPiechart(values: self.weeklyDetalsArray)
        // self.pieChartData(values: self.weeklyDetalsArray)
        // self.setLineChart(values: self.weeklyDetalsArray)
        print("weekly grapgh total ", self.weeklyDetalsArray)
    } fail: { error in
        print("getting errror")
    }
}
}
