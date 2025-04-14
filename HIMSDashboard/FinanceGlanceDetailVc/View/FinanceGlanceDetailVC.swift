//
//  FinanceGlanceDetailVC.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 31/10/23.
//

import UIKit
import Charts
import DGCharts
class FinanceGlanceDetailVC: UIViewController {

@IBOutlet weak var bankbalanceView: UIView!
@IBOutlet weak var cashView: UIView!
@IBOutlet weak var tableview: UITableView!
@IBOutlet weak var lineChartBtn: UIButton!
@IBOutlet weak var pieChartBtn: UIButton!
@IBOutlet weak var barChartBtn: UIButton!
@IBOutlet weak var landScapeChartBtn: UIButton!
@IBOutlet weak var rightArrowBtn: UIButton!
@IBOutlet weak var leftArrowBtn: UIButton!
@IBOutlet weak var backBtn: UIButton!
@IBOutlet weak var barView: UIView!
@IBOutlet weak var barChatImage: UIImageView!
@IBOutlet weak var pieChartImage: UIImageView!
@IBOutlet weak var lineChartImage: UIImageView!
@IBOutlet weak var rotateChartImage: UIImageView!
@IBOutlet weak var barchatView: BarChartView!
@IBOutlet weak var lineChartView: LineChartView!
@IBOutlet weak var pieChartView: PieChartView!
@IBOutlet weak var stackView: UIStackView!
@IBOutlet weak var bankAmountLbl: UILabel!
@IBOutlet weak var cashLbl: UILabel!
@IBOutlet weak var bankLbl: UILabel!
@IBOutlet weak var cashAmountLbl: UILabel!
@IBOutlet weak var dateFld: UITextField!
@IBOutlet weak var dateView: UIView!
@IBOutlet weak var headerLbl: UILabel!
var financeGlanceViewMOdel = FinanceGlanceViewModel()
var financeDict:FinanceGlanceModel?
var listArray = [FinanceGlanceDetailDtls]()
var totalSummeryArray = [FinanceGlanceDetailTotSummary]()
var selectedDate = Date().getZeroTime()
var datePicker:UIDatePicker = UIDatePicker()
var weeklyDetalsArray = [Int]()
var financeDetailStr = ""
var claintAPi = ""
var headerTitleStr = ""
var paidDates = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFld.tintColor = .white
        self.headerLbl.text = headerTitleStr
        allFunctions()
        print(selectedDate)
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
private func allFunctions() {
    setupCell()
    design()
    designView()
    self.showIndicator()
    //mark intails stage on screeen api call for display the graph and summnerdetails........
    if financeDetailStr == FinancialValidkeys.inDetails {
        self.headerLbl.text = "In Patient"
        self.opDetailAPi(url: Apis.inDetails, date: self.getTimeFormate(date: self.selectedDate))
    } else if financeDetailStr == FinancialValidkeys.opDetails {
        self.headerLbl.text = "Out Patient"
        self.opDetailAPi(url: Apis.opDetails, date: self.getTimeFormate(date: self.selectedDate))
    } else if financeDetailStr == FinancialValidkeys.pharmacyDetail {
        self.headerLbl.text = "Pharmacy"
        self.opDetailAPi(url: Apis.pharmacyDetail, date: self.getTimeFormate(date: self.selectedDate))
    } else if financeDetailStr == FinancialValidkeys.diagonsticDetail {
        self.headerLbl.text = "Diagnostics"
        self.opDetailAPi(url: Apis.diagonsticDetail, date: self.getTimeFormate(date: self.selectedDate))
    }
    print("selecteddateis:",self.selectedDate)
    weeklySummerDetailsApi(claiantUrl: self.claintAPi, date:self.getTimeFormate(date: self.selectedDate) )
    }
private func setupCell() {
    
    self.tableview.register(UINib(nibName: StoryBoardIdentifiers.FinanceGlanceDetailCell, bundle: nil), forCellReuseIdentifier: StoryBoardIdentifiers.FinanceGlanceDetailCell)
    self.tableview.register(UINib(nibName: StoryBoardIdentifiers.financeGlanceDetialHeaderCell, bundle: nil), forCellReuseIdentifier: StoryBoardIdentifiers.financeGlanceDetialHeaderCell)
}
private func design() {
    leftArrowBtn.setTitle("", for: .normal)
    rightArrowBtn.setTitle("", for: .normal)
    barChartBtn.setTitle("", for: .normal)
    lineChartBtn.setTitle("", for: .normal)
    pieChartBtn.setTitle("", for: .normal)
    landScapeChartBtn.setTitle("", for: .normal)
    backBtn.setTitle("", for: .normal)
    bankbalanceView.layer.cornerRadius = 8
    cashView.layer.cornerRadius = 8
    cashView.clipsToBounds = true
    bankbalanceView.clipsToBounds = true
    self.tableview.layer.cornerRadius = 4
    self.tableview.clipsToBounds = true
    self.barView.layer.cornerRadius = 4
    self.barView.clipsToBounds = true
    self.dateView.layer.cornerRadius = 15
    self.dateView.clipsToBounds = true
}
private func designView() {
        //radiusView(view: self.barView)
    dateFld.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))

    self.barChatImage.layer.cornerRadius = self.barChatImage.frame.size.width/2
    self.barChatImage.clipsToBounds = true
    self.barChatImage.contentMode = .scaleToFill
    
    self.pieChartImage.layer.cornerRadius = self.barChatImage.frame.size.width/2
    self.pieChartImage.clipsToBounds = true
    self.pieChartImage.contentMode = .scaleToFill
    
    self.lineChartImage.layer.cornerRadius = self.barChatImage.frame.size.width/2
    self.lineChartImage.clipsToBounds = true
    self.lineChartImage.contentMode = .scaleToFill
    
    self.rotateChartImage.layer.cornerRadius = self.barChatImage.frame.size.width/2
    self.rotateChartImage.clipsToBounds = true
    self.rotateChartImage.contentMode = .scaleToFill
    //self.tableview.layer.cornerRadius = 4
    self.dateFld.text = getTimeFormate(date: self.selectedDate)
    
    self.pieChartView.isHidden = true
    self.lineChartView.isHidden = true
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
    self.opDetailAPi(url: Apis.opDetails, date: currentDate)
    weeklySummerDetailsApi(claiantUrl: self.claintAPi, date: currentDate)
    self.dateFld.resignFirstResponder()
}
private func chatBtnhideBasedonSelected(btn: UIButton, success:Bool) {
    btn.isHidden = success
    btn.setTitle("", for: .normal)
}
private func getTimeFormate(date: Date)-> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYY-MM-dd"
    let dateString = dateFormatter.string(from: date)
    return dateString
}
@IBAction func chartActBtn(_ sender: UIButton) {
    switch sender.tag {
    case 1:
        self.barchatView.isHidden = false
        self.pieChartView.isHidden = true
        self.lineChartView.isHidden = true
       // self.setPieChartColor(color: .white)
    case 2:
        self.barchatView.isHidden = true
        self.pieChartView.isHidden = false
        self.lineChartView.isHidden = true
       // self.setPieChartColor(color: .white)
    case 3:
        self.barchatView.isHidden = true
        self.pieChartView.isHidden = true
        self.lineChartView.isHidden = false
       // self.setPieChartColor(color: .white)
    case 4:
        print("12345678")
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: StoryBoardIdentifiers.FullBarchatVC) as! FullBarchatVC
//        vc.weekBarDataArray = self.weeklyDetalsArray
//        self.navigationController?.pushViewController(vc, animated: true)
    default:
        break
    }
}
private func opDetailAPi(url:String,date: String) {
    self.financeGlanceViewMOdel.opDetailsAPi(glananceDetailApi: url, baseUrl: self.claintAPi, selectedDate: date, success: { [self] responce in
        print(responce)
        hideIndicator()
        self.totalSummeryArray.removeAll()
        self.listArray.removeAll()
        self.hideIndicator()
        self.financeDict = responce
        self.financeDict?.dtls?.forEach({ Dtls in
            self.listArray.append(Dtls)
        })
        print("total values:-\(self.listArray.count)")
        self.totalSummeryArray = (self.financeDict?.totSummary)!
        self.cashAmountLbl.text = totalSummeryArray[0].tTYPE
        self.cashLbl.text = "₹ \(totalSummeryArray[0].aMT ?? 0)"
        
        self.bankAmountLbl.text = totalSummeryArray[1].tTYPE
        self.bankLbl.text = "₹ \(totalSummeryArray[1].aMT ?? 0)"
        DispatchQueue.main.async {
            self.tableview.reloadData()
        }
        
    }, fail: { error in
        print("Getting error")
    })
}
@IBAction func previousDateActBtn(_ sender: UIButton) {
    // self.showIndicator()
    let cal = Calendar.current
    let date = cal.date(byAdding: .day, value: -1, to: self.selectedDate)
    self.selectedDate = date!.getZeroTime()
    dateFld.text = "\(getTimeFormate(date: self.selectedDate))"
    
    if financeDetailStr == "inDetails" {
         self.opDetailAPi(url: Apis.inDetails, date: self.getTimeFormate(date: self.selectedDate))
    } else if financeDetailStr == "opDetails" {
         self.opDetailAPi(url: Apis.opDetails, date: self.getTimeFormate(date: self.selectedDate))
    } else if financeDetailStr == "pharmacyDetail" {
         self.opDetailAPi(url: Apis.pharmacyDetail, date: self.getTimeFormate(date: self.selectedDate))
    } else if financeDetailStr == "diagonsticDetail" {
         self.opDetailAPi(url: Apis.diagonsticDetail, date: self.getTimeFormate(date: self.selectedDate))
    }
    //self.opDetailAPi(url: Apis.opDetails, date: self.getTimeFormate(date: self.selectedDate))
    weeklySummerDetailsApi(claiantUrl: self.claintAPi, date:self.getTimeFormate(date: self.selectedDate) )
    }
    
    @IBAction func nextDateBtn(_ sender: UIButton) {
       // self.showIndicator()
        let cal = Calendar.current
        let date = cal.date(byAdding: .day, value: 1, to: self.selectedDate)
        if date!.compare(Date()) == .orderedAscending {
            self.selectedDate = date!.getZeroTime()
         }
        dateFld.text = "\(getTimeFormate(date: self.selectedDate))"
        self.showIndicator()
        
        if financeDetailStr == "inDetails" {
             self.opDetailAPi(url: Apis.inDetails, date: self.getTimeFormate(date: self.selectedDate))
        } else if financeDetailStr == "opDetails" {
             self.opDetailAPi(url: Apis.opDetails, date: self.getTimeFormate(date: self.selectedDate))
        } else if financeDetailStr == "pharmacyDetail" {
             self.opDetailAPi(url: Apis.pharmacyDetail, date: self.getTimeFormate(date: self.selectedDate))
        } else if financeDetailStr == "diagonsticDetail" {
             self.opDetailAPi(url: Apis.diagonsticDetail, date: self.getTimeFormate(date: self.selectedDate))
        }
     //   self.opDetailAPi(url: Apis.opDetails, date: self.getTimeFormate(date: self.selectedDate))
        weeklySummerDetailsApi(claiantUrl: self.claintAPi, date:self.getTimeFormate(date: self.selectedDate) )

        print(getTimeFormate(date: self.selectedDate))
        
    }
    
@IBAction func backActBtn(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
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
}
extension FinanceGlanceDetailVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return self.listArray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoardIdentifiers.FinanceGlanceDetailCell) as! FinanceGlanceDetailCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoardIdentifiers.financeGlanceDetialHeaderCell) as! financeGlanceDetialHeaderCell
            let model = self.listArray[indexPath.row]
            cell.ttypLbl.text = model.tTYPE
            cell.cntLbl.text = "\(model.cNT ?? 0)"
            cell.amountLbl.text = "₹ \(model.aMT ?? 0)"
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.listArray[indexPath.row]
        
       // cell.ttypLbl.text = model.tTYPE
       // cell.cntLbl.text = "\(model.cNT ?? 0)"
       // cell.amountLbl.text = "\(model.aMT ?? 0)"
        let vc = self.storyboard?.instantiateViewController(withIdentifier: StoryBoardIdentifiers.PdfVC) as! PdfVC
        vc.reportType = model.tTYPE ?? ""
        vc.claintAPi = self.claintAPi
        vc.selectedDate = self.dateFld.text ?? ""
        vc.clickFrom = self.financeDetailStr
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 40
        } else {
            return 40

        }
    }
    
}
extension FinanceGlanceDetailVC {
private func weeklySummerDetailsApi(claiantUrl:String,date: String) {
    self.financeGlanceViewMOdel.dashBoardAWeekSummerAPi(baseUrl: claiantUrl, selectedDate: date) { responce in
        print("Weekly patent responce", responce)
        self.hideIndicator()
        var dateString = ""
        self.paidDates.removeAll()
        self.weeklyDetalsArray.removeAll()
        for dict in responce {
            self.weeklyDetalsArray.append(dict.total ?? 0)
            
            let dateFormatter = DateFormatter()
            dateString = dict.paidDate ?? ""
            
            // Set the input format of the date string
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            
            // Convert the string to a Date object
            if let date = dateFormatter.date(from: dateString) {
                // Create another date formatter for the output format
                let outputDateFormatter = DateFormatter()
                outputDateFormatter.dateFormat = "dd/yyyy" // Change this to whatever format you desire
                
                // Convert the Date object to a string in the desired format
                let formattedDate = outputDateFormatter.string(from: date)
                print(formattedDate) // This will print the formatted date string
                self.paidDates.append(formattedDate)
            }
        }
        self.setChart(values: self.weeklyDetalsArray)
         //  self.setPiechart(values: self.weeklyDetalsArray)
        self.pieChartData(values: self.weeklyDetalsArray)
    self.setLineChart(values: self.weeklyDetalsArray)
        
        print("weekly grapgh total ", self.weeklyDetalsArray)
    } fail: { error in
        print("getting errror")
    }
}
private func setChart(values: [Int]) {
    barchatView.noDataText = "You need to provide data for the chart."
    //self.setPieChartColor(color: .white)
    var dataEntries: [BarChartDataEntry] = []
    for i in 0..<values.count {
        let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
        dataEntries.append(dataEntry)
    }
    let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Athen Tech")
    chartDataSet.colors = ChartColorTemplates.colorful()
    // chartDataSet.colors = colorsOfCharts(numbersOfColor: values.count)
    barchatView.setScaleEnabled(false)
    barchatView.xAxis.valueFormatter = IndexAxisValueFormatter(values: self.paidDates)
    barchatView.xAxis.labelFont = UIFont.systemFont(ofSize: 7) // Change font size as needed
   // barchatView.xAxis.labelTextColor = .blue

    chartDataSet.drawValuesEnabled = true
    let chartData = BarChartData(dataSet: chartDataSet)
    barchatView.data = chartData
}
    
func pieChartData(values: [Int]) {
    // 1. Set ChartDataEntry
    var dataEntries: [ChartDataEntry] = []
    for i in 0..<values.count {
        let dataEntry = PieChartDataEntry(value: Double(values[i]), data:  values[i] as AnyObject)
        dataEntries.append(dataEntry)
    }
    // 2. Set ChartDataSet
    let pieChartDataSet = PieChartDataSet(entries: dataEntries, label: "Athen Tech")
    //  pieChartDataSet.colors = colorsOfCharts(numbersOfColor: values.count)
    pieChartDataSet.colors = ChartColorTemplates.colorful() // Use predefined colors
    // 3. Set ChartData
    let pieChartData = PieChartData(dataSet: pieChartDataSet)
    let format = NumberFormatter()
    format.numberStyle = .none
    let formatter = DefaultValueFormatter(formatter: format)
    pieChartData.setValueFormatter(formatter)
    // 4. Assign it to the chart's data
     
 
    pieChartView.data = pieChartData
    }
    
    func setLineChart(values:[Int]) {
              
        var entrys = [ChartDataEntry]()
        for x in 0..<values.count {
            print(x)
            entrys.append(ChartDataEntry(x: Double(x), y: Double(values[x])))
        }
        let lineChartDataSet = LineChartDataSet(entries: entrys, label: "Athen Tech")
        let lineChartData = LineChartData(dataSet: lineChartDataSet)
        
        lineChartDataSet.colors = colorsOfCharts(numbersOfColor: values.count)//[NSUIColor.blue] // Line color
       // lineChartDataSet.circleColors = colorsOfCharts(numbersOfColor: values.count)//[NSUIColor.blue] // Circle
    //    lineChartDataSet.drawFilledEnabled = true // Enable filling
        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.leftAxis.axisMinimum = 10
        lineChartView.setScaleEnabled(false)
        lineChartView.data = lineChartData
        
        let legend = lineChartView.legend
        legend.enabled = true
        legend.horizontalAlignment = .center
        legend.verticalAlignment = .bottom
        legend.orientation = .horizontal
        legend.drawInside = false
        
        // Optionally, customize the xAxis and yAxis
        let xAxis = lineChartView.xAxis
        xAxis.labelPosition = .bottom

        let leftAxis = lineChartView.leftAxis
        leftAxis.labelPosition = .outsideChart
        leftAxis.spaceTop = 0.1
        leftAxis.spaceBottom = 0.1

        let rightAxis = lineChartView.rightAxis
        rightAxis.enabled = false
        lineChartView.xAxis.labelCount = values.count
    }
}
extension FinanceGlanceDetailVC:UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
