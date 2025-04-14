//
//  LicenseVC.swift
//  HIMSDashboard
//
//  Created by ATHENTECH INDIA on 20/07/23.
//

import UIKit
class LicenseVC: UIViewController {
@IBOutlet weak var submitBtn: UIButton!
@IBOutlet weak var licenseView: UIView!
@IBOutlet weak var licenseKeyFld: UITextField!
var licenseViewModel = LicenseViewModel()
    
override func viewDidLoad() {
     super.viewDidLoad()
    
    let key = UserDefaults.standard.value(forKey: UserDefaultsKeys.licenceKey) as? String ?? ""
    let login = UserDefaults.standard.bool(forKey: UserDefaultsKeys.login_Flag)
    if login == true {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: StoryBoardIdentifiers.DashBoardVC) as! DashBoardVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    design()
    if key != "" && login == false{
        let vc = self.storyboard?.instantiateViewController(withIdentifier: StoryBoardIdentifiers.LoginVC) as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    self.licenseKeyFld.text = licenseKey
        
}
func design() {
    licenseView.layer.cornerRadius = 8//roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 8)
    licenseView.clipsToBounds = true
    
    submitBtn.layer.cornerRadius = 8//roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 8)
    submitBtn.clipsToBounds = true
}
func licenseApiCall(Authorization:String) {
    licenseViewModel.licenseAPi(key: Authorization) { responce in
        self.hideIndicator()
        print(responce)
        var stauts = ""
        for i in responce {
            stauts = i.status ?? ""
        }
        if stauts == "Success" {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: StoryBoardIdentifiers.LoginVC) as! LoginVC
            vc.listArray = responce
            self.navigationController?.pushViewController(vc, animated: true)
            // self.showAlert(withTitle: Alert.title, withMessage: status ?? "")
        } else {
            self.showAlert(withTitle: Alert.title, withMessage: stauts )
            
        }
    } fail: { error in
        print("getting error")
    }
    }
@IBAction func submitActBtn(_ sender: Any) {
    if licenseKeyFld.text == "" {
        self.showAlert(withTitle: Alert.title, withMessage: Alert.licenseAlert)
    } else {
        self.showIndicator()
        UserDefaults.standard.setValue(self.licenseKeyFld.text ?? "", forKey: "licenceKey")
        self.licenseApiCall(Authorization: self.licenseKeyFld.text ?? "")
    }
}
    
}
