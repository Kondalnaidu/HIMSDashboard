//
//  GSTSummaryVC.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 11/02/24.
//
import UIKit
class GSTSummaryVC: UIViewController {
@IBOutlet weak var backBtn: UIButton!
@IBOutlet weak var GSTableview: UITableView!
var appDelegate = UIApplication.shared.delegate as? AppDelegate
var gstViewModel = GSTsummaryViewModel()
var baseUrl = ""
@IBOutlet weak var headerLbl: UILabel!
    var gstArray = [GSTModel]()
var total = [Float]()
var taxTotal = [Float]()
var sgTotal = [Float]()
    var cgTotal = [Float]()
    var igTotal = [Float]()
    var netTotal = [Float]()
    var comingFromSidemenuFlag = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.comingFromSidemenuFlag == "GST Summary" {
            
            self.headerLbl.text = "GST Summary"
        } else {
            self.headerLbl.text = "GST Monthly"
        }
        appDelegate?.myOrientation = .landscape
        setupCell()
        
        
     }
@IBAction func backActBtn(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
    }
    private func setupCell() {
    self.GSTableview.register(UINib(nibName: "GSTSummeryCell", bundle: nil), forCellReuseIdentifier: "GSTSummeryCell")
    self.GSTableview.register(UINib(nibName: "GSTTitleCell", bundle: nil), forCellReuseIdentifier: "GSTTitleCell")//RevenueDetailMothlyCell
    self.GSTableview.register(UINib(nibName: "GSTDataCell", bundle: nil), forCellReuseIdentifier: "GSTDataCell")//RevenueDetailMothlyCell//RevenueTotalCell
    self.GSTableview.register(UINib(nibName: "GstTotalCell", bundle: nil), forCellReuseIdentifier: "GstTotalCell")//RevenueDetailMothlyCell//RevenueTotalCell

    self.backBtn.setTitle("", for: .normal)//GstTotalCell
}
private func gstAPi(fromDate: String, toDate: String, type:String,saleType: String) {
    
    self.showIndicator()
    self.baseUrl = UserDefaults.standard.value(forKey: "claint_Url") as! String
    
    print("baseurllikeclainturl",self.baseUrl)
    var url = ""
    if saleType == "Sales" {
        url = "\(self.baseUrl+Apis.gstSummary)FromDate=\(fromDate)&ToDate=\(toDate)&Type=\(type)"
    } else {
        url = "\(self.baseUrl+Apis.gstPurchase)FromDate=\(fromDate)&ToDate=\(toDate)"
    }
    gstViewModel.gstSummaryApi(baseUrl: url) { responce in
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
            self.total.append(model.total ?? 0)
            self.taxTotal.append(model.taxAmount ?? 0)
            self.sgTotal.append(model.sGSTAmt ?? 0)
            self.cgTotal.append(model.cGSTAmt ?? 0)
            self.igTotal.append(model.iGSTAmt ?? 0)
            self.netTotal.append(model.netAmount ?? 0)
        }
        print("Total is:-\(self.total), tax total is:- \(self.taxTotal), sgtotal is:- \(self.sgTotal), cgtotal is:- \(self.cgTotal), igtotal is:- \(self.igTotal), nettotal is:- \(self.netTotal)")
        
        DispatchQueue.main.async {
            self.GSTableview.reloadData()
        }
    } fail: { error in
        print("Getting error")
    }
}
}
extension GSTSummaryVC: UITableViewDelegate, UITableViewDataSource {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "GSTSummeryCell") as! GSTSummeryCell
        cell.delegate = self
         return cell
    } else if indexPath.section == 1{
        let cell = tableView.dequeueReusableCell(withIdentifier: "GSTTitleCell") as! GSTTitleCell
        return cell
    } else if indexPath.section == 2{
        let model = self.gstArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "GSTDataCell") as! GSTDataCell
        cell.gstLbl.text = "\(model.taxPer ?? 0)"
        cell.totalLbl.text = "₹ \(model.total ?? 0)"
        cell.txtAmtLbl.text = "₹ \(model.taxAmount ?? 0)"
        cell.sgLbl.text = "₹ \(model.sGSTAmt ?? 0)"
        cell.cgLbl.text = "₹ \(model.cGSTAmt ?? 0)"
        cell.igLbl.text = "₹ \(model.iGSTAmt ?? 0)"
        cell.netLbl.text = "₹ \(model.netAmount ?? 0)"
        return cell
    }  else if indexPath.section == 3 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GstTotalCell") as! GstTotalCell
        cell.totalLbl.text = "₹ \(self.total.reduce(0, +))"
        cell.taxTotalLbl.text = "₹ \(self.taxTotal.reduce(0, +))"
        cell.sgTotalLbl.text = "₹ \(self.sgTotal.reduce(0, +))"
        cell.cgTotalLbl.text = "₹ \(self.cgTotal.reduce(0, +))"
        cell.igTotalLbl.text = "₹ \(self.igTotal.reduce(0, +))"
        cell.netTotalLbl.text = "₹ \(self.netTotal.reduce(0, +))"
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
extension GSTSummaryVC: gstProtocol {
    func getGstData(fromDate: String, toDate: String, type: String, saleType: String) {
        self.gstAPi(fromDate: fromDate, toDate: toDate, type: type, saleType: saleType)
    }
}
