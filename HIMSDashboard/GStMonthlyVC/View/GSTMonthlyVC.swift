//
//  GSTSummaryVC.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 11/02/24.
//
import UIKit
class GSTMonthlyVC: UIViewController {
@IBOutlet weak var backBtn: UIButton!    
@IBOutlet weak var gstMonthlyTableView: UITableView!
@IBOutlet weak var headerLbl: UILabel!
var appDelegate = UIApplication.shared.delegate as? AppDelegate
var gstMonthlyViewModel = GSTMonthlyViewModel()
var gstArray = [GSTMonthlyModel]()
var total = [Float]()
var taxTotal = [Float]()
var sgTotal = [Float]()
var cgTotal = [Float]()
var igTotal = [Float]()
var netTotal = [Float]()
var comingFromSidemenuFlag = ""
var baseUrl = ""


    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.comingFromSidemenuFlag == "GST Summary" {
            self.headerLbl.text = "GST Summary"
        } else {
            self.headerLbl.text = "GST Monthly"
        }
        appDelegate?.myOrientation = .landscape
        setupCell()
        
        backBtn.addTarget(self, action: #selector(popBackActBtn), for: .touchUpInside)
    }
@objc func popBackActBtn() {
    self.navigationController?.popViewController(animated: true)
}
    
private func setupCell() {
    self.gstMonthlyTableView.register(UINib(nibName: StoryBoardIdentifiers.GSTMonthlyCell, bundle: nil), forCellReuseIdentifier: StoryBoardIdentifiers.GSTMonthlyCell)
    self.gstMonthlyTableView.register(UINib(nibName: StoryBoardIdentifiers.GSTMonthlyTitleCell, bundle: nil), forCellReuseIdentifier:StoryBoardIdentifiers.GSTMonthlyTitleCell )//RevenueDetailMothlyCell
    self.gstMonthlyTableView.register(UINib(nibName: StoryBoardIdentifiers.GSTMonthlyDataCell, bundle: nil), forCellReuseIdentifier: StoryBoardIdentifiers.GSTMonthlyDataCell)//RevenueDetailMothlyCell//RevenueTotalCell
    self.gstMonthlyTableView.register(UINib(nibName: StoryBoardIdentifiers.GSTMonthlyTotalCell, bundle: nil), forCellReuseIdentifier: StoryBoardIdentifiers.GSTMonthlyTotalCell)//RevenueDetailMothlyCell//RevenueTotalCell
    
    self.backBtn.setTitle("", for: .normal)//GstTotalCell
}
@IBAction func backActBtn(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
    }
    private func gstAPi(fromDate: String, toDate: String, type:String,saleType: String) {
    var month = 0
    self.showIndicator()
        self.baseUrl = UserDefaults.standard.value(forKey: UserDefaultsKeys.claint_Url) as! String
    print("baseurllikeclainturl",self.baseUrl)
        if fromDate == MonthKeys.January {
        month = 1
        } else if fromDate == MonthKeys.February {
        month = 2
        } else if fromDate == MonthKeys.March {
        month = 3
        } else if fromDate == MonthKeys.April {
        month = 4
        } else if fromDate == MonthKeys.May {
        month = 5
        } else if fromDate == MonthKeys.June{
        month = 5
        } else if fromDate == MonthKeys.July {
        month = 6
        } else if fromDate == MonthKeys.August {
        month = 7
        } else if fromDate == MonthKeys.September {
        month = 8
        } else if fromDate == MonthKeys.October {
        month = 9
        } else if fromDate == MonthKeys.November {
        month = 10
        } else if fromDate == MonthKeys.December {
        month = 11
    }
    var url = ""
    if saleType == "Sales" {
        url = "\(self.baseUrl+Apis.gstSaleMonthly)Month=\(month)&Year=\(toDate)&Type=\(type)"
    } else {
        url = "\(self.baseUrl+Apis.gstPurchaseMonthly)Month=\(month)&Year=\(toDate)"
    }
    gstMonthlyViewModel.gstSummaryApi(baseUrl: url) { responce in
        self.hideIndicator()
        self.gstArray.removeAll()
        self.total.removeAll()
        self.taxTotal.removeAll()
        self.sgTotal.removeAll()
        self.cgTotal.removeAll()
        self.igTotal.removeAll()
        self.netTotal.removeAll()
        self.gstArray.append(contentsOf: responce)
        print("gstsummaryresponce",self.gstArray.count)
        self.gstArray.forEach { model in
//            self.total.append(model.total ?? 0)
//            self.taxTotal.append(model.taxAmount ?? 0)
//            self.sgTotal.append(model.sGSTAmt ?? 0)
//            self.cgTotal.append(model.cGSTAmt ?? 0)
//            self.igTotal.append(model.iGSTAmt ?? 0)
//            self.netTotal.append(model.netAmount ?? 0)
        }
        print("Total is:-\(self.total), tax total is:- \(self.taxTotal), sgtotal is:- \(self.sgTotal), cgtotal is:- \(self.cgTotal), igtotal is:- \(self.igTotal), nettotal is:- \(self.netTotal)")
        
        DispatchQueue.main.async {
            self.gstMonthlyTableView.reloadData()
        }
    } fail: { error in
        print("Getting error")
    }
}
}
extension GSTMonthlyVC: UITableViewDelegate, UITableViewDataSource {
func numberOfSections(in tableView: UITableView) -> Int {
        return 4
}
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
        return 1
    } else if section == 1{
        return 1
    } else if section == 2{
        return self.gstArray.count
    } else if section == 3{
        return 1

    } else {
        return 1
    }
}
    
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoardIdentifiers.GSTMonthlyCell) as! GSTMonthlyCell
        cell.delegate = self
         return cell
    } else if indexPath.section == 1{
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoardIdentifiers.GSTMonthlyTitleCell) as! GSTMonthlyTitleCell
        return cell
    } else if indexPath.section == 2{
        let model = self.gstArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoardIdentifiers.GSTMonthlyDataCell) as! GSTMonthlyDataCell
        cell.saleDateLbl.text = model.sALEDT
        cell.zeroTaxbleLbl.text = "\(model.taxable0 ?? 0)"
        cell.fiveTaxbleLbl.text = "\(model.taxable0 ?? 0)"
        cell.fiveGstLbl.text = "\(model.gST5 ?? 0)"
        cell.twelTaxbleLbl.text = "\(model.taxable12 ?? 0)"
        cell.twelgstlLbl.text = "\(model.gST12 ?? 0)"
        cell.eightenTaxbleLbl.text = "\(model.taxable18 ?? 0)"
        cell.eighteenGstLbl.text = "\(model.gST18 ?? 0)"
        cell.twentyEightTaxbleLbl.text = "\(model.taxable28 ?? 0)"
        cell.twentyEightyGstLbl.text = "\(model.gST28 ?? 0)"
        return cell
    }  else if indexPath.section == 3 {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoardIdentifiers.GSTMonthlyTotalCell) as! GSTMonthlyTotalCell
//        cell.totalLbl.text = "₹ \(self.total.reduce(0, +))"
//        cell.taxTotalLbl.text = "₹ \(self.taxTotal.reduce(0, +))"
//        cell.sgTotalLbl.text = "₹ \(self.sgTotal.reduce(0, +))"
//        cell.cgTotalLbl.text = "₹ \(self.cgTotal.reduce(0, +))"
//        cell.igTotalLbl.text = "₹ \(self.igTotal.reduce(0, +))"
//        cell.netTotalLbl.text = "₹ \(self.netTotal.reduce(0, +))"
        return cell
    }
    else {
        return UITableViewCell()
    }
}
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 60
        } else if indexPath.section == 1 {
            return 40
        } else if indexPath.section == 2 {
            return 40
        }
        else {
            return 50
        }
    }
}
extension GSTMonthlyVC: gstMonthlyProtocol {
    func getGstData(fromDate: String, toDate: String, type: String, saleType: String) {
        self.gstAPi(fromDate: fromDate, toDate: toDate, type: type, saleType: saleType)
    }
}
