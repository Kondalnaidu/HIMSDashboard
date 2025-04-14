//
//  TotalSummeryVC.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 05/11/23.
//

import UIKit

class TotalSummeryVC: UIViewController {
    @IBOutlet weak var backBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    var totalSummeryViewModel = TotalSummeryViewModel()
    var claintAPi = ""
    var selectedDate = Date().getZeroTime()
    var totalCashArray = [TotalCash]()
    var totalMoneyArray = [TotalBank]()
    var totalDict: TotalSummeryModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.totalSummeryApi()
        setupCell()
        design()
        
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
    
    private func setupCell() {
        tableView.register(UINib(nibName: "TotalSummerCell", bundle: nil), forCellReuseIdentifier: "TotalSummerCell")
        tableView.register(UINib(nibName: "TotalSummerTypeCell", bundle: nil), forCellReuseIdentifier: "TotalSummerTypeCell")

        tableView.delegate = self
        tableView.dataSource = self
        
    }
    private func totalSummeryApi(){
        print(claintAPi)
        self.totalSummeryViewModel.totalSummeryAPi(glananceDetailApi: Apis.totalSummeryDetails, url: self.claintAPi, selectedDate: self.getTimeFormate(date: self.selectedDate)) { responce in
            self.totalCashArray.removeAll()
            self.totalMoneyArray.removeAll()
             responce.cash?.forEach({ TotalCash in
                
                self.totalCashArray.append(TotalCash)
            })
            self.totalDict = responce
            responce.bank?.forEach({ value in
                self.totalMoneyArray.append(value)
                
            })

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            print(self.totalCashArray)
        } fail: { error in
            print(error)
        }


    }
    private func getTimeFormate(date: Date)-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYY/MM/dd"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
    private func design() {
        self.backBtn.setTitle("", for: .normal)

    }
    
    @IBAction func backActBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension TotalSummeryVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return self.totalCashArray.count

        } else {
            return self.totalMoneyArray.count
        }
        
         
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TotalSummerTypeCell") as! TotalSummerTypeCell
            let model = self.totalCashArray[indexPath.row]
            cell.titleLbl.text = model.tTYPE
            cell.amouuntLbl.text = "\(model.aMT ?? 0)"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TotalSummerTypeCell") as! TotalSummerTypeCell
            let model = self.totalMoneyArray[indexPath.row]
            let v = Double(model.aMT ?? 0)
            cell.titleLbl.text = model.tTYPE
            cell.amouuntLbl.text = "\(v)"
            return cell
        }
       // return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var headerView = tableView.dequeueReusableCell(withIdentifier: "TotalSummerCell") as! TotalSummerCell
 
        if section == 0 {
            headerView.titleLbl.text = "₹ \(self.totalDict?.totCash ?? 0)"
            headerView.bankNameLbl.text = "Total Cash"
            headerView.designView.layer.shadowOpacity = 1
            headerView.designView.layer.shadowOffset = CGSize(width: 0, height: 1)
            headerView.designView.layer.shadowRadius = 1
 
        } else {
            headerView.titleLbl.text = "₹ \(self.totalDict?.totBank ?? 0)"
            headerView.bankNameLbl.text = "Total Bank"
            headerView.designView.layer.shadowOpacity = 0.5
            headerView.designView.layer.shadowOffset = CGSize(width: 0, height: 1)
            headerView.designView.layer.shadowRadius = 1
        }
       
            return headerView
        }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // Return the desired height for your custom header view
        return 75 // You can adjust the height as needed.
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}
extension UIView {

func addShadowView() {
    //Remove previous shadow views
    //superview?.viewWithTag(119900)?.removeFromSuperview()

    //Create new shadow view with frame
    let shadowView = UIView(frame: frame)
    //shadowView.tag = 119900
    shadowView.layer.shadowColor = UIColor.black.cgColor
    shadowView.layer.shadowOffset = CGSize(width: 5, height: 2)
    shadowView.layer.masksToBounds = false

    shadowView.layer.shadowOpacity = 0.5
    shadowView.layer.shadowRadius = 2
    shadowView.layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    shadowView.layer.rasterizationScale = UIScreen.main.scale
    shadowView.layer.shouldRasterize = true
    shadowView.layer.cornerRadius = 10
   // shadowView.clipsToBounds = true
    superview?.insertSubview(shadowView, belowSubview: self)
}}
