//
//  AdmissionVC.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 05/12/23.
//

import UIKit

class AdmissionVC: UIViewController {
@IBOutlet weak var backBtn: UIButton!
@IBOutlet weak var admissionTableView: UITableView!
@IBOutlet weak var typeFld: UITextField!
@IBOutlet weak var typeView: UIView!
@IBOutlet weak var yearFld: UITextField!
@IBOutlet weak var yearView: UIView!
var admissionViewModel = AdmissionViewModel()
var monthArray = ["Jan","Feb","March","April","May"]
var typeArray = ["All", "Cash", "Organization"]
lazy var years: [Int] = {
    let currentYear = Calendar.current.component(.year, from: Date())
    return Array((currentYear - 100)...currentYear).reversed() // Adjust the range as needed
}()
var basedOnSelectedFLd = 0
var baseUrl = ""
var selectedYear = 0
var selectedType = 0
var yearFlag: Bool = false
var typeFlag: Bool = false
var admissionListArray = [AdmissionModel]()
var aCount = 0
var dCount = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCell()
    }
private func setupCell() {
    self.admissionTableView.register(UINib(nibName: StoryBoardIdentifiers.AdmissionHeaderCell, bundle: nil), forCellReuseIdentifier: StoryBoardIdentifiers.AdmissionHeaderCell)
    self.admissionTableView.register(UINib(nibName: StoryBoardIdentifiers.AdmissionDataCell, bundle: nil), forCellReuseIdentifier: StoryBoardIdentifiers.AdmissionDataCell)
    self.admissionTableView.register(UINib(nibName: StoryBoardIdentifiers.AdmissionBottomCell, bundle: nil), forCellReuseIdentifier: StoryBoardIdentifiers.AdmissionBottomCell)
    self.admissionTableView.reloadData()
    self.typeFld.textFieldCornerRadius(radius: 4)
    self.yearFld.textFieldCornerRadius(radius: 4)
    self.backBtn.setTitle("", for: .normal)
    self.yearView.setViewCornerRadius(radius: 4)
    self.typeView.setViewCornerRadius(radius: 4)
 
}
private func setupPickerView(fld: UITextField) {
    var pickerView = UIPickerView()
    pickerView.delegate = self
    pickerView.dataSource = self
    // Assign the UIPickerView to the text field's inputView
    fld.inputView = pickerView
    
    // Add a toolbar with a Done button to dismiss the UIPickerView
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    
    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonPressed))
    let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    toolbar.setItems([cancelBarButton, flexibleSpace, doneButton], animated: true)
    
    fld.inputAccessoryView = toolbar
    pickerView.reloadAllComponents()
    
    // Set the text field delegate to handle user interactions
    //fld.delegate = self
}
@objc func cancelPressed() {
    if self.basedOnSelectedFLd == 1 {
        yearFld.resignFirstResponder()
    } else {
        typeFld.resignFirstResponder()
    }
    }
@objc func doneButtonPressed() {
     var type = ""
    if self.basedOnSelectedFLd == 1 {
        self.yearFld.text = "\(years[selectedYear])"
         yearFld.resignFirstResponder()
    } else {
        self.typeFld.text = "\(typeArray[selectedType])"

        typeFld.resignFirstResponder()
    }
    if self.yearFlag && typeFlag {
        if self.typeFld.text  == AdmissionTypeKeys.All{
            type = "0"
        } else if self.typeFld.text == AdmissionTypeKeys.Cash{
            type = "1"
        } else if self.typeFld.text == AdmissionTypeKeys.Organization{
            type = "2"
        }
        self.admissionCountAPi(year: Int(self.yearFld.text ?? "") ?? 0, type: type)
    }
    
}
private func admissionCountAPi(year: Int, type: String) {
    self.baseUrl = UserDefaults.standard.value(forKey: UserDefaultsKeys.claint_Url) as! String
    let url = "\(self.baseUrl+Apis.AdmissionCount)Year=\(year)&Type=\(type)"
    self.admissionViewModel.admissionCountApi(baseUrl: url) { responce in
        print(responce)
        self.admissionListArray.removeAll()
        
        var value = 0
        self.admissionListArray = responce
        var admissionCount = [Int]()
        var dischargeCount = [Int]()
        admissionCount.removeAll()
        dischargeCount.removeAll()
        for dict in self.admissionListArray {
            admissionCount.append(dict.admnCnt ?? 0)
            dischargeCount.append(dict.dischCnt ?? 0)

         }
        self.aCount = admissionCount.reduce(0, +)
        self.dCount = dischargeCount.reduce(0, +)

        print("Total_countAPi",self.aCount,self.dCount)
        
    
        self.admissionTableView.reloadData()

    } fail: { error in
        print("getting error")
    }
}
@IBAction func backActBtn(_ sender: UIButton) {
    self.navigationController?.popViewController(animated: true)
}
}
extension AdmissionVC: UITableViewDelegate, UITableViewDataSource {
func numberOfSections(in tableView: UITableView) -> Int {
    return 3
}
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == 0 {
        return 1
    } else if section == 1 {
        return self.admissionListArray.count
    } else {
        return 1
    }
}
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    if indexPath.section == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoardIdentifiers.AdmissionHeaderCell) as! AdmissionHeaderCell
        return cell
    } else  if indexPath.section == 1{
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoardIdentifiers.AdmissionDataCell) as! AdmissionDataCell
        cell.monthLbl.text = self.admissionListArray[indexPath.row].monthNM
        cell.admissionLbl.text = "\(self.admissionListArray[indexPath.row].admnCnt ?? 0)"
        cell.discharggeLbl.text = "\(self.admissionListArray[indexPath.row].dischCnt ?? 0)"
        cell.admissionBtn.addTarget(self, action: #selector(admissionActBtn), for: .touchUpInside)
        cell.admissionBtn.tag = indexPath.row
        cell.admissionBtn.setTitle("", for: .normal)
        cell.dischargeBtn.addTarget(self, action: #selector(dischargeActBtn), for: .touchUpInside)
        cell.dischargeBtn.tag = indexPath.row
        cell.dischargeBtn.setTitle("", for: .normal)
        return cell
    } else {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryBoardIdentifiers.AdmissionBottomCell) as! AdmissionBottomCell
          cell.admissionTotalCountLbl.text = "\(aCount)"
        cell.dischargeTotalCountLbl.text = "\(dCount)"
        return cell
    }
    return UITableViewCell()
}
    
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    if indexPath.section == 0 {
        return 30
    } else if indexPath.section == 1 {
        return 40
    } else {
        return 40
    }
}
    @objc func admissionActBtn(sender: UIButton) {
        print("admission\(sender.tag)")
        let month = self.admissionListArray[sender.tag].monthNM
        print("monthadmission:\(month)")
        let vc = self.storyboard?.instantiateViewController(identifier: StoryBoardIdentifiers.AdmissionWebVC) as! AdmissionWebVC
        vc.year = self.years[selectedYear]
        vc.type =  0
        if month == MonthKeys.April {
            vc.month = 4
        } else if month == MonthKeys.May {
            vc.month = 5
        } else if month == MonthKeys.June {
            vc.month = 6
        } else if month == MonthKeys.July {
            vc.month = 7
        } else if month == MonthKeys.August {
            vc.month = 8
        } else if month == MonthKeys.September {
            vc.month = 9
        } else if month == MonthKeys.October {
            vc.month = 10
        } else if month == MonthKeys.November {
            vc.month = 11
        } else if month == MonthKeys.December {
            vc.month = 12
        } else if month == MonthKeys.January {
            vc.month = 1
        }
        else if month == MonthKeys.February {
            vc.month = 2
        }
        else if month == MonthKeys.March {
            vc.month = 3
        }
        self.navigationController?.pushViewController(vc, animated: true)
         
    }
    @objc func dischargeActBtn(sender: UIButton) {
        print("discharge\(sender.tag)")
        let month = self.admissionListArray[sender.tag].monthNM
        print("monthDischarge:\(month ?? "")")
        let vc = self.storyboard?.instantiateViewController(identifier: StoryBoardIdentifiers.AdmissionWebVC) as! AdmissionWebVC
        vc.year = self.years[selectedYear]
        vc.type =  1
        if month == MonthKeys.April {
            vc.month = 4
        } else if month == MonthKeys.May {
            vc.month = 5
        } else if month == MonthKeys.June {
            vc.month = 6
        } else if month == MonthKeys.July {
            vc.month = 7
        } else if month == MonthKeys.August {
            vc.month = 8
        } else if month == MonthKeys.September {
            vc.month = 9
        } else if month == MonthKeys.October {
            vc.month = 10
        } else if month == MonthKeys.November {
            vc.month = 11
        } else if month == MonthKeys.December {
            vc.month = 12
        } else if month == MonthKeys.January {
            vc.month = 1
        } else if month == MonthKeys.February{
            vc.month = 2
        }
        else if month == MonthKeys.March{
            vc.month = 3
        }
        self.navigationController?.pushViewController(vc, animated: true)
         
    }
}
extension AdmissionVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
        }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if self.basedOnSelectedFLd == 1 {
            return years.count
        } else {
            return typeArray.count
        }
    }
    
    // MARK: - UIPickerViewDelegate

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if self.basedOnSelectedFLd == 1 {
                return "\(years[row])"
            } else {
                return typeArray[row]
            }
        }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            var type = ""
            let selectedYear = years[row]
            if self.basedOnSelectedFLd == 1 {
                self.yearFld.text = "\(selectedYear)"
                print("Selected year: \(selectedYear)")
                self.selectedYear = row
             } else {
                 self.typeFld.text = typeArray[row]
                 self.selectedType = row
             }
            if self.yearFlag && typeFlag {
                if self.typeFld.text  == AdmissionTypeKeys.All {
                    type = "0"
                } else if self.typeFld.text == AdmissionTypeKeys.Cash{
                    type = "1"
                } else if self.typeFld.text == AdmissionTypeKeys.Organization {
                    type = "2"
                }
                self.admissionCountAPi(year: Int(self.yearFld.text ?? "") ?? 0, type: type)
            }
        }
}
extension AdmissionVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.yearFld {
            setupPickerView(fld: self.yearFld)
            self.basedOnSelectedFLd = 1
            self.yearFlag = true
        } else {
            self.basedOnSelectedFLd = 2
            setupPickerView(fld: typeFld)
            self.typeFlag = true
        }
        return true
    }
}
