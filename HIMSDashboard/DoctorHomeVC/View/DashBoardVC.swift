//
//  DashBoardVC.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 12/08/23.
//

import UIKit
import DGCharts
import SideMenu
import FBLPromises
class DashBoardVC: UIViewController {
    
@IBOutlet weak var outPatientView: UIView!
@IBOutlet weak var inPatientView: UIView!
@IBOutlet weak var diagonosticView: UIView!
@IBOutlet weak var pharmacyView: UIView!
@IBOutlet weak var totalView: UIView!
@IBOutlet weak var experianceView: UIView!
@IBOutlet weak var newPatientView: UIView!
@IBOutlet weak var oldPatientView: UIView!
@IBOutlet weak var totalPatientView: UIView!
@IBOutlet weak var barChatView: BarChartView!
@IBOutlet weak var outPatientPriceLbl: UILabel!
@IBOutlet weak var pharmacyPriceLbl: UILabel!
@IBOutlet weak var diagnosticPriceLbl: UILabel!
@IBOutlet weak var inPatientLbl: UILabel!
@IBOutlet weak var admissionView: UIView!
@IBOutlet weak var dischargeView: UIView!
@IBOutlet weak var occupatancyView: UIView!
@IBOutlet weak var sideMenuBtn: UIButton!
@IBOutlet weak var totalPriceLbl: UILabel!
@IBOutlet weak var ExpenditurePriceLbl: UILabel!
@IBOutlet weak var newPatientPriceLbl: UILabel!
@IBOutlet weak var oldPatientLbl: UILabel!
@IBOutlet weak var totalPatientPriceLbl: UILabel!
@IBOutlet weak var admissionPriceLbl: UILabel!
@IBOutlet weak var occupancyPriceLbl: UILabel!
@IBOutlet weak var dischargePriceLbl: UILabel!
@IBOutlet weak var dateView: UIView!
@IBOutlet weak var previousDateBtn: UIButton!
@IBOutlet weak var nextDateBtn: UIButton!
@IBOutlet weak var currentDateLbl: UILabel!
@IBOutlet weak var barView: UIView!
@IBOutlet weak var expedurePriceLbl: UILabel!
@IBOutlet weak var pieChartView: PieChartView!
@IBOutlet weak var pieChartBtn: UIButton!
@IBOutlet weak var barChatBtn: UIButton!
@IBOutlet weak var lineChartView: LineChartView!
@IBOutlet weak var lineChartBtn: UIButton!
@IBOutlet weak var rotateBtn: UIButton!
@IBOutlet weak var selectDateBtn: UIButton!
@IBOutlet weak var currentDateFld: UITextField!
@IBOutlet weak var barChatImage: UIImageView!
@IBOutlet weak var pieChartImage: UIImageView!
@IBOutlet weak var lineChartImage: UIImageView!
@IBOutlet weak var rotateChartImage: UIImageView!
var doctorViewModel = DoctorViewModel()
var summerListArray = [DoctorHomeModel]()
var selectedDate = Date().getZeroTime()
var datePicker:UIDatePicker = UIDatePicker()
var toolBar = UIToolbar()
let dispatchGroup = DispatchGroup()
var appDelegate = UIApplication.shared.delegate as? AppDelegate
var operationQueue: OperationQueue = OperationQueue()
var paidDates = [String]()
var weeklyDetalsArray = [Int]()
var claintAPi = ""
    
     override func viewDidLoad() {
        super.viewDidLoad()
         
         allFuctions()
         //  overrideUserInterfaceStyle = .light
         //  overrideUserInterfaceStyle = .dark
         let view = UIView()
         view.overrideUserInterfaceStyle = .dark
         // currentDateFld.isUserInteractionEnabled = false
         //currentDateFld.isEnabled = false
         currentDateFld.tintColor = .white

      }
override func viewWillAppear(_ animated: Bool) {
    appDelegate?.myOrientation = .portrait
}
private func allFuctions() {
    designView()
    setSideMenu()
    self.showIndicator()
    navigateToFinancialGlanceDetailPage()
    self.currentDateFld.text = getTimeFormate(date: self.selectedDate)
    print("selected date current",getTimeFormate(date: self.selectedDate))
    self.previousDateBtn.setTitle("", for: .normal)
    self.nextDateBtn.setTitle("", for: .normal)
    
    currentDateFld.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
    
    self.claintAPi = UserDefaults.standard.value(forKey: UserDefaultsKeys.claint_Url) as? String ?? ""
    operationQueue.maxConcurrentOperationCount = 4
    operationQueue.addOperation(summerApi())
    operationQueue.addOperation(patientApi())
    operationQueue.addOperation(admissionAPi())
    operationQueue.addOperation(weeklySummerApi())
}
    
private func designView() {
    radiusView(view: self.outPatientView)
    radiusView(view: self.inPatientView)
    radiusView(view: self.diagonosticView)
    radiusView(view: self.pharmacyView)
    radiusView(view: self.totalView)
    radiusView(view: self.experianceView)
    radiusView(view: self.newPatientView)
    radiusView(view: self.oldPatientView)
    radiusView(view: self.totalPatientView)
    radiusView(view: self.admissionView)
    radiusView(view: self.dischargeView)
    radiusView(view: self.occupatancyView)
    // radiusView(view: self.barView)
    barView.layer.cornerRadius = 6
    barView.clipsToBounds = true
    radiusView(view: self.dateView)
    
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
    
    //self.dateView.roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 8)
    //self.barView.roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 8)
    chatBtnhideBasedonSelected(btn: self.barChatBtn, success: false)
    chatBtnhideBasedonSelected(btn: self.pieChartBtn, success: false)
    chatBtnhideBasedonSelected(btn: self.lineChartBtn, success: false)
    chatBtnhideBasedonSelected(btn: rotateBtn, success: false)
    
    self.pieChartView.isHidden = true
    self.lineChartView.isHidden = true
}
private func navigateToFinancialGlanceDetailPage() {
    let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
    self.outPatientView.addGestureRecognizer(tap)
    
    let admissionVC = UITapGestureRecognizer(target: self, action: #selector(self.dischargeHandleTap(_:)))
    self.dischargeView.addGestureRecognizer(admissionVC)
    
    let admissionView = UITapGestureRecognizer(target: self, action: #selector(self.admissionChargeeHandleTap(_:)))
    self.admissionView.addGestureRecognizer(admissionView)
    
    let occupatancyView = UITapGestureRecognizer(target: self, action: #selector(self.occupancyHandleTap(_:)))
    self.occupatancyView.addGestureRecognizer(occupatancyView)
    
    let inPutView = UITapGestureRecognizer(target: self, action: #selector(self.inPutViewhandleTap(_:)))
    self.inPatientView.addGestureRecognizer(inPutView)
    
    let pharmacyView = UITapGestureRecognizer(target: self, action: #selector(self.pharmacyViewhandleTap(_:)))
    self.pharmacyView.addGestureRecognizer(pharmacyView)
    
    let diogonsticView = UITapGestureRecognizer(target: self, action: #selector(self.diogonsticViewViewhandleTap(_:)))
    self.diagonosticView.addGestureRecognizer(diogonsticView)
    
    let totalView = UITapGestureRecognizer(target: self, action: #selector(self.totalViewViewhandleTap(_:)))
    self.totalView.addGestureRecognizer(totalView)
    
    let excependTure = UITapGestureRecognizer(target: self, action: #selector(self.excependTureViewhandleTap(_:)))
    self.experianceView.addGestureRecognizer(excependTure)
}
@objc func dischargeHandleTap(_ sender: UITapGestureRecognizer? = nil) {
    let vc = self.storyboard?.instantiateViewController(withIdentifier: StoryBoardIdentifiers.DischargeDetailVC) as! DischargeDetailVC
    vc.claintAPi = self.claintAPi
    vc.clickFrom = AdmissionDischargeValidationkeys.Discharge
    vc.selectedDate = self.selectedDate
    self.navigationController?.pushViewController(vc, animated: true)
}
    @objc func occupancyHandleTap(_ sender: UITapGestureRecognizer? = nil) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: StoryBoardIdentifiers.DischargeDetailVC) as! DischargeDetailVC
        vc.claintAPi = self.claintAPi
        vc.clickFrom = AdmissionDischargeValidationkeys.Occupancy
        vc.selectedDate = self.selectedDate
        self.navigationController?.pushViewController(vc, animated: true)
    }
@objc func admissionChargeeHandleTap(_ sender: UITapGestureRecognizer? = nil) {
    let vc = self.storyboard?.instantiateViewController(withIdentifier: StoryBoardIdentifiers.DischargeDetailVC) as! DischargeDetailVC
    vc.clickFrom = AdmissionDischargeValidationkeys.Admission
    vc.claintAPi = self.claintAPi
    vc.selectedDate = self.selectedDate
    self.navigationController?.pushViewController(vc, animated: true)
}
@objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
    // handling code
    let vc = self.storyboard?.instantiateViewController(withIdentifier: StoryBoardIdentifiers.FinanceGlanceDetailVC) as! FinanceGlanceDetailVC
    vc.claintAPi = self.claintAPi
    vc.financeDetailStr = FinancialValidkeys.opDetails
    vc.selectedDate = self.selectedDate
    self.navigationController?.pushViewController(vc, animated: true)
}
@objc func inPutViewhandleTap(_ sender: UITapGestureRecognizer? = nil) {
    // handling code
    let vc = self.storyboard?.instantiateViewController(withIdentifier: StoryBoardIdentifiers.FinanceGlanceDetailVC) as! FinanceGlanceDetailVC
    vc.claintAPi = self.claintAPi
    vc.financeDetailStr = FinancialValidkeys.inDetails
    vc.selectedDate = self.selectedDate
    self.navigationController?.pushViewController(vc, animated: true)
}
@objc func pharmacyViewhandleTap(_ sender: UITapGestureRecognizer? = nil) {
    // handling code
    let vc = self.storyboard?.instantiateViewController(withIdentifier: StoryBoardIdentifiers.FinanceGlanceDetailVC) as! FinanceGlanceDetailVC
    vc.claintAPi = self.claintAPi
    vc.financeDetailStr = FinancialValidkeys.pharmacyDetail
    vc.selectedDate = self.selectedDate
    self.navigationController?.pushViewController(vc, animated: true)
}
@objc func diogonsticViewViewhandleTap(_ sender: UITapGestureRecognizer? = nil) {
    // handling code
    let vc = self.storyboard?.instantiateViewController(withIdentifier: StoryBoardIdentifiers.FinanceGlanceDetailVC) as! FinanceGlanceDetailVC
    vc.claintAPi = self.claintAPi
    vc.financeDetailStr = FinancialValidkeys.diagonsticDetail
    vc.selectedDate = self.selectedDate
    self.navigationController?.pushViewController(vc, animated: true)
}
@objc func totalViewViewhandleTap(_ sender: UITapGestureRecognizer? = nil) {
    // handling code
    let vc = self.storyboard?.instantiateViewController(withIdentifier: StoryBoardIdentifiers.TotalSummeryVC) as! TotalSummeryVC
    vc.claintAPi = self.claintAPi
    vc.selectedDate = self.selectedDate
    self.navigationController?.pushViewController(vc, animated: true)
}
@objc func excependTureViewhandleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
    let vc = self.storyboard?.instantiateViewController(withIdentifier: StoryBoardIdentifiers.ExpendtureVC) as! ExpendtureVC
    vc.claintAPi = self.claintAPi
    vc.selectedDate = self.selectedDate
    // vc.financeDetailStr = "expenduture"
    self.navigationController?.pushViewController(vc, animated: true)
}
@objc func doneButtonPressed() {
    var currentDate = ""
    let dateFormatter = DateFormatter()
    if let  datePicker = self.currentDateFld.inputView as? UIDatePicker {
        
        dateFormatter.dateFormat = "YYY-MM-dd"
        // dateFormatter.dateStyle = .medium
        self.currentDateFld.text = dateFormatter.string(from: datePicker.date)
        currentDate = self.currentDateFld.text ?? ""
    }
    if let convertedDate = dateFormatter.date(from: currentDate) {
        let dateObject: Date = convertedDate
        // Now you can use dateObject as a Date
        self.selectedDate = dateObject
        print(dateObject)
    } else {
        print("Invalid date format")
    }
   // self.selectedDate = dateFormatter.string(from: datePicker.date)
    print("self.basedonSelectedTime", currentDate)
    self.showIndicator()
    summerApiCall(claiantUrl: self.claintAPi, date: currentDate )
    pateintAPi(claiantUrl: self.claintAPi, date:  currentDate)
    admissionApi(claiantUrl: self.claintAPi, date: currentDate)
    weeklySummerDetailsApi(claiantUrl: self.claintAPi, date:currentDate)
    self.currentDateFld.resignFirstResponder()
     }
@objc func doneClick() {
    let dateFormatter1 = DateFormatter()
    dateFormatter1.dateStyle = .medium
    dateFormatter1.timeStyle = .none
    datePicker.isHidden = true
    self.toolBar.isHidden = true
}
@objc func cancelClick() {
    datePicker.isHidden = true
    self.toolBar.isHidden = true
}
func setSideMenu() {
    sideMenuBtn.setTitle("", for: .normal)
    let menuVC = self.storyboard?.instantiateViewController(withIdentifier: StoryBoardIdentifiers.SideMenuVC)
    let menuLeftNavigationController = SideMenuNavigationController(rootViewController: menuVC!)
    menuLeftNavigationController.leftSide = true
    SideMenuManager.default.leftMenuNavigationController = menuLeftNavigationController
}
private func chatBtnhideBasedonSelected(btn: UIButton, success:Bool) {
    btn.isHidden = success
    btn.setTitle("", for: .normal)
}
private func radiusView(view:UIView) {
    view.layer.cornerRadius = 15
    view.clipsToBounds = true
}
private func setPieChartColor(color: UIColor) {
    self.barView.backgroundColor = color
    self.pieChartView.backgroundColor = color
}
@IBAction func selectDateActBtn(_ sender: UIButton) {
}
@objc func datePickerValueChanged(_ sender: UIDatePicker) {
      //  let selectedDate = sender.date
        // Do something with the selectedDate
}
@IBAction func prevousDateActbtn(_ sender: UIButton) {
    self.showIndicator()
    let cal = Calendar.current
    let date = cal.date(byAdding: .day, value: -1, to: self.selectedDate)
    self.selectedDate = date!.getZeroTime()
    operationQueue.addOperation(summerApi())
    operationQueue.addOperation(patientApi())
    operationQueue.addOperation(admissionAPi())
    operationQueue.addOperation(weeklySummerApi())
    currentDateFld.text = "\(getTimeFormate(date: self.selectedDate))"
}
@IBAction func nextDateActBtn(_ sender: UIButton) {
    self.showIndicator()
    let cal = Calendar.current
    let date = cal.date(byAdding: .day, value: 1, to: self.selectedDate)
    if date!.compare(Date()) == .orderedAscending {
        self.selectedDate = date!.getZeroTime()
    }
    operationQueue.addOperation(summerApi())
    operationQueue.addOperation(patientApi())
    operationQueue.addOperation(admissionAPi())
    operationQueue.addOperation(weeklySummerApi())
    currentDateFld.text = "\(getTimeFormate(date: self.selectedDate))"
    print(getTimeFormate(date: self.selectedDate))
}
private func getTimeFormate(date: Date)-> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "YYY-MM-dd"
    let dateString = dateFormatter.string(from: date)
    return dateString
}
@IBAction func sideMenuActBtn(_ sender: UIButton) {
    sideMenuBtn.setTitle("", for: .normal)
    present(SideMenuManager.default.leftMenuNavigationController!, animated: true, completion: nil)
}
@IBAction func chatActBtn(_ sender: UIButton) {
    switch sender.tag {
    case 1:
        self.barChatView.isHidden = false
        self.pieChartView.isHidden = true
        self.lineChartView.isHidden = true
        self.setPieChartColor(color: .white)
    case 2:
        self.barChatView.isHidden = true
        self.pieChartView.isHidden = false
        self.lineChartView.isHidden = true
        self.setPieChartColor(color: .white)
    case 3:
        self.barChatView.isHidden = true
        self.pieChartView.isHidden = true
        self.lineChartView.isHidden = false
        self.setPieChartColor(color: .white)
    case 4:
        let vc = self.storyboard?.instantiateViewController(withIdentifier: StoryBoardIdentifiers.FullBarchatVC) as! FullBarchatVC
        vc.weekBarDataArray = self.weeklyDetalsArray
        self.navigationController?.pushViewController(vc, animated: true)
    default:
        break
    }
}
private func basedSelectedChartShow(selectedChart:UIButton) {}
}
extension DashBoardVC {
    // Here API callings...........
private func summerApiCall(claiantUrl:String,date: String) {
    print(date,claiantUrl)
    self.doctorViewModel.homeScreensummmerApi(baseUrl: claiantUrl, selectedDate: date) { responce in
        print("home screen summer responce", responce)
        self.hideIndicator()
        self.summerListArray.removeAll()
        self.summerListArray = responce
        for dict in responce {
            self.outPatientPriceLbl.text = "₹ \(dict.oPFinGlance ?? 0)"
            self.inPatientLbl.text = "₹ \(dict.iPFinGlance ?? 0)"
            self.pharmacyPriceLbl.text = "₹ \(dict.phamaFinGlance ?? 0)"
            self.diagnosticPriceLbl.text = "₹ \(dict.diagFinGlance ?? 0)"
            self.totalPriceLbl.text = "₹ \(dict.totalFinGlance ?? 0)"
            self.expedurePriceLbl.text = "₹ \(dict.expenditure ?? 0)"
        }
    } fail: { error in
        print("getting error")
    }
}
private func admissionApi(claiantUrl:String,date: String) {
    self.doctorViewModel.dashBoardAdmissionAPi(baseUrl: claiantUrl, selectedDate: date) { responce in
        print("patient responce", responce)
        self.hideIndicator()
        for dict in responce {
            self.dischargePriceLbl.text = "₹ \(dict.DischrgeCnt ?? 0)"
            self.admissionPriceLbl.text = "₹ \(dict.AdmnCnt ?? 0)"
            self.occupancyPriceLbl.text = "₹ \(dict.BedCnt ?? 0)"
        }
        
    } fail: { error in
        print("getting errror")
    }
}
private func weeklySummerDetailsApi(claiantUrl:String,date: String) {
    self.doctorViewModel.dashBoardAWeekSummerAPi(baseUrl: claiantUrl, selectedDate: date) { responce in
        print("Weekly patent responce", responce)
        self.hideIndicator()
        self.weeklyDetalsArray.removeAll()
        self.paidDates.removeAll()
        var dateString = ""
        for dict in responce {
            self.weeklyDetalsArray.append(dict.total ?? 0)
            // self.paidDates.append(dict.paidDate ?? "")
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
            } else {
                print("Invalid date format")
            }
        }
        
        
        print("paiddatesgettingfrom",self.paidDates)
        
        //self.setBarchat(barchatView: self.barChatView)
        self.setChart(values: self.weeklyDetalsArray)
        //  self.setPiechart(values: self.weeklyDetalsArray)
        self.pieChartData(values: self.weeklyDetalsArray)
    self.setLineChart(values: self.weeklyDetalsArray)
        

        
        print("weekly grapgh total ", self.weeklyDetalsArray)
    } fail: { error in
        print("getting errror")
    }
}
func summerApi() -> Operation {
    //self.showIndicator()
    let operation: Operation = BlockOperation { () -> Void in
        self.summerApiCall(claiantUrl: self.claintAPi, date: self.getTimeFormate(date: self.selectedDate))
    }
    return operation
}
func patientApi() -> Operation {
    //self.showIndicator()
    let operation: Operation = BlockOperation { () -> Void in
        self.pateintAPi(claiantUrl: self.claintAPi, date: self.getTimeFormate(date: self.selectedDate))
    }
    return operation
}
func admissionAPi() -> Operation {
    // self.showIndicator()
    let operation: Operation = BlockOperation { () -> Void in
        self.admissionApi(claiantUrl: self.claintAPi, date: self.getTimeFormate(date: self.selectedDate))
    }
    return operation
}
func weeklySummerApi() -> Operation {
    //self.showIndicator()
    let operation: Operation = BlockOperation { () -> Void in
        self.weeklySummerDetailsApi(claiantUrl: self.claintAPi, date: self.getTimeFormate(date: self.selectedDate))
    }
    return operation
}
private func pateintAPi(claiantUrl:String,date: String) {
    self.doctorViewModel.dashBoardPatientAPi(baseUrl: claiantUrl, selectedDate: date) { responce in
        print("patient responce", responce)
        self.hideIndicator()
        for dict in responce {
            let new: Int = dict.NewPatCnt ?? 0
            let old:Int = dict.RVPatCnt ?? 0
            let total:Int = new + old
            self.newPatientPriceLbl.text = "₹ \(dict.NewPatCnt ?? 0)"
            self.oldPatientLbl.text = "₹ \(dict.RVPatCnt ?? 0)"
            self.totalPatientPriceLbl.text = "₹ \(total)"
        }
    } fail: { error in
        print(error)
    }
    
}

}
// cgarts api callll
extension DashBoardVC {
func setChart(values: [Int]) {
    barChatView.noDataText = "You need to provide data for the chart."
    //self.setPieChartColor(color: .white)
    var dataEntries: [BarChartDataEntry] = []
    for i in 0..<values.count {
        let dataEntry = BarChartDataEntry(x: Double(i), y: Double(values[i]))
        dataEntries.append(dataEntry)
    }
    let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Athen Tech")
    // chartDataSet.colors = ChartColorTemplates.colorful()
    chartDataSet.colors = ChartColorTemplates.colorful()//colorsOfCharts(numbersOfColor: values.count)
    let chartData = BarChartData(dataSet: chartDataSet)
    barChatView.setScaleEnabled(false)
    barChatView.xAxis.valueFormatter = IndexAxisValueFormatter(values: self.paidDates)
    barChatView.xAxis.labelFont = UIFont.systemFont(ofSize: 7) // Change font size as needed
   // barChatView.xAxis.labelTextColor = .darkGray
     chartDataSet.drawValuesEnabled = true
    barChatView.data = chartData
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
extension UITextField {

func addInputViewDatePicker(target: Any, selector: Selector) {
   let screenWidth = UIScreen.main.bounds.width
   //Add DatePicker as inputView
   let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
   datePicker.datePickerMode = .date
   self.inputView = datePicker
      if #available(iOS 14, *) {
          datePicker.preferredDatePickerStyle = .wheels
      }
      datePicker.maximumDate = Date()
      datePicker.backgroundColor = .white//UIColor(red: 44/255.0, green: 110/255.0, blue: 160/255.0, alpha: 1)
      datePicker.setValue(UIColor.black, forKey:"textColor")
    //Add Tool Bar as input AccessoryView
   let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
   let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
   let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
   let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
   toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)

   self.inputAccessoryView = toolBar
}

  @objc func cancelPressed() {
    self.resignFirstResponder()
  }
}
extension DashBoardVC: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
           // Return false to prevent the text field from becoming the first responder
           return false
       }
}
