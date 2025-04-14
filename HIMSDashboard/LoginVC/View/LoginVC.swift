//
//  LoginVC.swift
//  HIMSDashboard
//
//  Created by ATHENTECH INDIA on 20/07/23.
//

import UIKit

class LoginVC: UIViewController {
    
@IBOutlet weak var claintNameLbl: UILabel!
@IBOutlet weak var athentechLogo: UIImageView!
@IBOutlet weak var locationView: UIView!
@IBOutlet weak var mobileView: UIView!
@IBOutlet weak var passwordView: UIView!
@IBOutlet weak var locationFld: UITextField!
@IBOutlet weak var numberFld: UITextField!
@IBOutlet weak var passwordFld: UITextField!
@IBOutlet weak var loginBtn: UIButton!
@IBOutlet weak var checkImageView: UIImageView!
var licenseViewModel = LicenseViewModel()
var filterPickerView = UIPickerView()
var listArray = [LicenseModel]()
var claintApi = ""
var userName = "Admin"
var password = "torrent345"
var loginViewModel = LoginViewModel()
var locationStr = ""
    var checkFlag: Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let key = UserDefaults.standard.value(forKey: UserDefaultsKeys.licenceKey) as? String ?? ""
        let login = UserDefaults.standard.bool(forKey: UserDefaultsKeys.login_Flag)

        if key != "" && login == false {
           // self.checkFlag = true
            if let v = UserDefaults.standard.value(forKey: "claint_Url") as? String {
                self.claintApi = v//UserDefaults.standard.value(forKey: "claint_Url") as! String
                self.locationFld.text = "\(UserDefaults.standard.value(forKey: UserDefaultsKeys.location) ?? "")"
                self.numberFld.text = "\(UserDefaults.standard.value(forKey: UserDefaultsKeys.userName) ?? "")"
                self.passwordFld.text = "\(UserDefaults.standard.value(forKey: UserDefaultsKeys.passWord) ?? "")"
                self.checkImageView.image = UIImage(named: "check")

            }

        
        }
        
        self.allMethods()
 
            
     }
private func allMethods() {
    let key = UserDefaults.standard.value(forKey: UserDefaultsKeys.licenceKey) as? String ?? ""
    self.showIndicator()
    self.licenseApiCall(Authorization: key)
    setupDesign()
}
@objc func donePicker() {
    self.locationFld.resignFirstResponder()
    print("click done")
}
@objc func cancelPicker() {
    self.locationFld.resignFirstResponder()
    print("click cancel")
}
override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)
}
func setupDesign() {
    locationView.layer.cornerRadius = 8//roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 8)
    locationView.clipsToBounds = true
    
    mobileView.layer.cornerRadius = 8//roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 8)
    mobileView.clipsToBounds = true
    
    passwordView.layer.cornerRadius = 8//roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 8)
    passwordView.clipsToBounds = true
    loginBtn.layer.cornerRadius = 8//roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 8)
    loginBtn.clipsToBounds = true
    self.passwordFld.isSecureTextEntry = true
}
@IBAction func loginActBtn(_ sender: UIButton) {
    if self.locationFld.text == "" {
        self.showAlert(withTitle: Alert.title, withMessage: Alert.locationAlert)
    } else if self.numberFld.text == "" {
        self.showAlert(withTitle: Alert.title, withMessage: Alert.numberAlert)
    } else if self.passwordFld.text == "" {
        self.showAlert(withTitle: Alert.title, withMessage: Alert.passowrdAlert)
    } else {
        UserDefaults.standard.setValue(self.numberFld.text ?? "", forKey: UserDefaultsKeys.userName)
        UserDefaults.standard.setValue(self.passwordFld.text ?? "", forKey: UserDefaultsKeys.passWord)
        //self.hideIndicator()
        self.showIndicator()
        self.loginApi(name: self.numberFld.text ?? "", pass: self.passwordFld.text ?? "")
    }
}
    private func loginApi() {
        
    }
@IBAction func checkBtn(_ sender: UIButton) {
    if self.checkFlag {
         self.checkImageView.image = UIImage(named: "un_check")
        self.numberFld.text = ""
        self.passwordFld.text = ""
        self.locationFld.text = ""
        self.checkFlag = false
    } else {
        if sender.isSelected == false {
            sender.isSelected = true
            self.checkImageView.image = UIImage(named: "check")
            self.numberFld.text = "\(UserDefaults.standard.value(forKey: UserDefaultsKeys.userName) ?? "")"
            self.passwordFld.text = "\(UserDefaults.standard.value(forKey: UserDefaultsKeys.passWord) ?? "")"
            self.locationFld.text = "\(UserDefaults.standard.value(forKey: UserDefaultsKeys.location) ?? "")"
        } else {
            sender.isSelected = false
            self.checkImageView.image = UIImage(named: "un_check")
            self.numberFld.text = ""
            self.passwordFld.text = ""
            self.locationFld.text = ""

        }
    }
    
}
}
extension LoginVC: UIPickerViewDelegate, UIPickerViewDataSource {

func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
}
func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return self.listArray.count
}
func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    let model = self.listArray[row]
    return model.clientName
}
func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    let model = self.listArray[row]
    guard let url = URL(string: model.logoURL ?? "") else { return  }
    print("logoUrlbased on claint", url)
    self.athentechLogo.load(url: url)
    self.claintNameLbl.text = model.clientName
    self.locationFld.text = model.clientName
    self.claintApi = model.clientURL ?? ""
    self.locationStr = model.clientName ?? ""
    UserDefaults.standard.setValue(self.claintApi, forKey: UserDefaultsKeys.claint_Url)
    UserDefaults.standard.setValue(self.locationStr, forKey: UserDefaultsKeys.location)

    print("ClaintUrl..............",claintApi)
}
}
extension LoginVC : UITextFieldDelegate {

public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    if textField == self.locationFld {
        self.setupPickerView(textfiled: self.locationFld)
    }
    return true
}
func textField(_ textField: UITextField,
               shouldChangeCharactersIn range: NSRange,
               replacementString string: String) -> Bool {
    
    if textField == self.numberFld {
        if let text = numberFld.text,
           let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            print("username\(updatedText)")
            UserDefaults.standard.setValue(updatedText, forKey: UserDefaultsKeys.userName)
        }
    } else if textField == self.passwordFld {
        if let text = passwordFld.text,
           let textRange = Range(range, in: text) {
            
            let updatedText = text.replacingCharacters(in: textRange,
                                                       with: string)
            print("password\(updatedText)")
            UserDefaults.standard.setValue(updatedText, forKey: UserDefaultsKeys.passWord)
}
        
    }
    return true
}
func setupPickerView(textfiled: UITextField) {
    let picker: UIPickerView
    picker = UIPickerView(frame: CGRectMake(0, 200, view.frame.width, 200))
    // picker.backgroundColor = UIColor(red: 44/255.0, green: 110/255.0, blue: 160/255.0, alpha: 1)
    
    picker.backgroundColor = UIColor(red: 44/255.0, green: 110/255.0, blue: 160/255.0, alpha: 1)
    picker.setValue(UIColor.white, forKey:"textColor")
    
    //  picker.showsSelectionIndicator = true
    picker.delegate = self
    picker.dataSource = self
    
    let toolBar = UIToolbar()
    toolBar.barStyle = UIBarStyle.default
    toolBar.isTranslucent = true
    toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
    toolBar.sizeToFit()
    
    let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
    let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.donePicker))
    toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
    toolBar.isUserInteractionEnabled = true
    textfiled.inputView = picker
    textfiled.inputAccessoryView = toolBar
    }
}
//Api calls
extension LoginVC {
    private func loginApi(name: String, pass: String) {
        loginViewModel.loginApi(baseUrl: self.claintApi, userName: name, password: pass) { responce in
            self.hideIndicator()
            print("login responce", responce)
            var status = ""
            let message = ""
            for dict in responce {
                status = dict.sTATUS ?? ""
             }
            if status == "SUCCESS"{//"" {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: StoryBoardIdentifiers.DashBoardVC) as! DashBoardVC
                vc.claintAPi = self.claintApi
                UserDefaults.standard.setValue(self.claintApi, forKey: UserDefaultsKeys.claint_Url)
                UserDefaults.standard.set(true, forKey: UserDefaultsKeys.login_Flag)
                self.navigationController?.pushViewController(vc, animated: true)

            } else {
                for dict in responce {
                    status = dict.url ?? ""
                }
                self.showAlert(withTitle: Alert.title, withMessage: status)

            }
            
        } fail: { error in
            print("getting error")
        }

    }
func licenseApiCall(Authorization:String) {
        licenseViewModel.licenseAPi(key: Authorization) { responce in
            self.hideIndicator()
            print(responce)
            self.hideIndicator()
            var stauts = ""
            for i in responce {
                stauts = i.status ?? ""
            }
            if stauts == "Success" {
                self.listArray = responce
             } else {
                self.showAlert(withTitle: Alert.title, withMessage: stauts )

            }
        } fail: { error in
            print("getting error")
        }

    }
}
