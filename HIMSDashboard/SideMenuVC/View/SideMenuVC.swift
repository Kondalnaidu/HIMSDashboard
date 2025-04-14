//
//  SideMenuVC.swift
//  HIMSDashboard
//
//  Created by ATHENTECH INDIA on 17/07/23.
//

import UIKit
import SideMenu
class SideMenuVC: BaseViewContrller {
@IBOutlet weak var profileImageView: UIImageView!
@IBOutlet weak var sideMenuTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCell()
        setupDesign()
        
     }
    
func setupCell() {
    sideMenuTableView.register(UINib(nibName: StoryBoardIdentifiers.SideMenuTableCell, bundle: nil), forCellReuseIdentifier: StoryBoardIdentifiers.SideMenuTableCell)
}
func setupDesign() {
    self.profileImageView.layer.cornerRadius = profileImageView.frame.size.height/2
    self.profileImageView.clipsToBounds = true
}
}
extension  SideMenuVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoardIdentifiers.SideMenuTableCell) as! SideMenuTableCell
        cell.sideNameLbl.text = sideMenuArray[indexPath.row]
        cell.sideImageView.image = UIImage(named: sideMenuImageArray[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let str = sideMenuArray[indexPath.row]
        if str == SideMenuValidationKeys.logOut {
            showAlertAction(title: Alert.title, message:Alert.logOutAlert)
        } else if str == SideMenuValidationKeys.doctorWiseRevenue {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: StoryBoardIdentifiers.DoctorWiseRevenueVC) as! DoctorWiseRevenueVC
            vc.comingFromSidemenuFlag = SideMenuValidationKeys.doctorWiseRevenue
            self.navigationController?.pushViewController(vc, animated: true)
        } else if str == SideMenuValidationKeys.admissionCount {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: StoryBoardIdentifiers.AdmissionVC) as! AdmissionVC
            self.navigationController?.pushViewController(vc, animated: true)
        } else if str == SideMenuValidationKeys.doctorCountAnalysis {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: StoryBoardIdentifiers.DoctorWiseRevenueVC) as! DoctorWiseRevenueVC
            vc.comingFromSidemenuFlag = SideMenuValidationKeys.doctorCountAnalysis
            self.navigationController?.pushViewController(vc, animated: true)
        } else if str == SideMenuValidationKeys.gSTSummary{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: StoryBoardIdentifiers.GSTSummaryVC) as! GSTSummaryVC
            vc.comingFromSidemenuFlag = StoryBoardIdentifiers.GSTSummaryVC
            self.navigationController?.pushViewController(vc, animated: true)
        } else if str == SideMenuValidationKeys.gSTMonthly{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: StoryBoardIdentifiers.GSTMonthlyVC) as! GSTMonthlyVC
             self.navigationController?.pushViewController(vc, animated: true)
        }
    }
func showAlertAction(title: String, message: String){
    let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
        print("Action")
        UserDefaults.standard.set(false, forKey: UserDefaultsKeys.login_Flag)//set(true, forKey: "login_Flag")
         let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: StoryBoardIdentifiers.LoginVC) as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
    }
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 60
}
    
    
}
