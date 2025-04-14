//
//  GSTSummeryCell.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 11/02/24.
//

import UIKit
protocol gstMonthlyProtocol {
    func getGstData(fromDate: String, toDate: String, type: String, saleType: String)
}
class GSTMonthlyCell: UITableViewCell {
@IBOutlet weak var typeFld: UITextField!
@IBOutlet weak var goBtn: UIButton!
@IBOutlet weak var saleTypeFld: UITextField!
@IBOutlet weak var toFld: UITextField!
@IBOutlet weak var fromFld: UITextField!

var basedOnSelectedFLd = 0
var selectedTypeRow = 0
var selectedDate = Date().getZeroTime()
var saleTypeRow = 0
var selectedYearRow = 0
var monthRow = 0
lazy var years: [Int] = {
        let currentYear = Calendar.current.component(.year, from: Date())
        return Array((currentYear - 100)...currentYear).reversed() // Adjust the range as needed
}()
var delegate: gstMonthlyProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        setupFldDelegateMethods(fld: self.fromFld)
        setupFldDelegateMethods(fld: self.toFld)
        setupFldDelegateMethods(fld: self.saleTypeFld)
        setupFldDelegateMethods(fld: self.typeFld)
        self.fromFld.layer.cornerRadius = 4
        self.toFld.layer.cornerRadius = 4
        self.saleTypeFld.layer.cornerRadius = 4
        self.typeFld.layer.cornerRadius = 4
        self.goBtn.addTarget(self, action: #selector(gotoActBtn), for: .touchUpInside)
     }
@objc func gotoActBtn() {
    if self.fromFld.text == "" || self.toFld.text == "" || self.typeFld.text == ""{
        //self.inputAccessoryViewController?.showAlert(withTitle: "", withMessage: "Please select all the flds")
    } else {
        if delegate != nil {
            delegate?.getGstData(fromDate: self.fromFld.text ?? "", toDate: self.toFld.text ?? "", type: self.typeFld.text ?? "", saleType: self.saleTypeFld.text ?? "")
    }
}
}
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

     }
private func setupFldDelegateMethods(fld: UITextField) {
    fld.delegate = self
}
func addInputViewDatePicker(fld:UITextField, selector: Selector) {
    let screenWidth = UIScreen.main.bounds.width
    //Add DatePicker as inputView
    let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
    datePicker.datePickerMode = .date
    fld.inputView = datePicker
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
    
    fld.inputAccessoryView = toolBar
   }
@objc func doneButtonPressedDated() {
    
    if self.basedOnSelectedFLd == 1 {
        var currentDate = ""
        let dateFormatter = DateFormatter()
        if let  datePicker = self.fromFld.inputView as? UIDatePicker {
            dateFormatter.dateFormat = "YYY-MM-dd"
            self.fromFld.text = dateFormatter.string(from: datePicker.date)
            currentDate = self.fromFld.text ?? ""
        }
        if let convertedDate = dateFormatter.date(from: currentDate) {
            let dateObject: Date = convertedDate
            // Now you can use dateObject as a Date
            self.selectedDate = dateObject
            print(dateObject)
        } else {
            print("Invalid date format")
        }
        print("self.basedonSelectedTime", currentDate)
        
    } else if basedOnSelectedFLd == 2{
        var currentDate = ""
        let dateFormatter = DateFormatter()
        if let  datePicker = self.toFld.inputView as? UIDatePicker {
            
            dateFormatter.dateFormat = "YYY-MM-dd"
            // dateFormatter.dateStyle = .medium
            self.toFld.text = dateFormatter.string(from: datePicker.date)
            currentDate = self.toFld.text ?? ""
        }
        if let convertedDate = dateFormatter.date(from: currentDate) {
            let dateObject: Date = convertedDate
            // Now you can use dateObject as a Date
            self.selectedDate = dateObject
            print(dateObject)
        } else {
            print("Invalid date format")
        }
        print("self.basedonSelectedTime", currentDate)
    }
    self.fromFld.resignFirstResponder()
    self.toFld.resignFirstResponder()
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
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        toolbar.setItems([cancelBarButton, flexibleSpace, doneButton], animated: true)
        fld.inputAccessoryView = toolbar
        pickerView.reloadAllComponents()
        // Set the text field delegate to handle user interactions
        //fld.delegate = self
}
@objc func cancelPressed() {
    if self.basedOnSelectedFLd == 1 {
        fromFld.resignFirstResponder()
    } else if self.basedOnSelectedFLd == 2{
        toFld.resignFirstResponder()
    } else if self.basedOnSelectedFLd == 3{
        saleTypeFld.resignFirstResponder()
    } else if self.basedOnSelectedFLd == 4{
        typeFld.resignFirstResponder()
    }
}
@objc func doneButtonPressed(sender:UIButton) {
    if self.basedOnSelectedFLd == 4 {
        self.typeFld.text = typeArray[selectedTypeRow]
        typeFld.resignFirstResponder()
        
    }  else if basedOnSelectedFLd == 3{
        self.saleTypeFld.text = saleTypeArray[saleTypeRow]
        saleTypeFld.resignFirstResponder()
        
    } else if basedOnSelectedFLd == 1{
        self.fromFld.text = monthsArray[monthRow]
        fromFld.resignFirstResponder()
        
    } else if basedOnSelectedFLd == 2 {
        self.toFld.text = "\(years[selectedYearRow])"
        toFld.resignFirstResponder()
    }
    else {
        typeFld.resignFirstResponder()
    }
    }
@IBAction func goActBtn(_ sender: UIButton) {
    
}
}
extension GSTMonthlyCell: UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == fromFld {
            self.basedOnSelectedFLd = 1
            self.setupPickerView(fld: fromFld)
            //fromFld.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressedDated))
        } else if textField == toFld{
            self.basedOnSelectedFLd = 2
           // toFld.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressedDated))
            self.setupPickerView(fld: toFld)
        } else if textField == saleTypeFld {
            self.basedOnSelectedFLd = 3
            self.setupPickerView(fld: saleTypeFld)
        } else if textField == typeFld {
            self.basedOnSelectedFLd = 4
            self.setupPickerView(fld: self.typeFld)
        }
        return true
    }
}

extension GSTMonthlyCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1//
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if basedOnSelectedFLd == 1 {
            return monthsArray.count
        } else if basedOnSelectedFLd == 2{
            return self.years.count
        }
        else if basedOnSelectedFLd == 3{
            return saleTypeArray.count
        }
        else {
            return typeArray.count
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if self.basedOnSelectedFLd == 1 {
            return "\(monthsArray[row])"
        } else if basedOnSelectedFLd == 2{
            return "\(self.years[row])"
        } else if self.basedOnSelectedFLd == 3 {
            return saleTypeArray[row]
        } else if basedOnSelectedFLd == 4 {
            return typeArray[row]
        } else {
            return ""
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if self.basedOnSelectedFLd == 4 {
            self.selectedTypeRow  = row
        } else if self.basedOnSelectedFLd == 3{
            self.saleTypeRow = row
        } else if self.basedOnSelectedFLd == 1{
            self.monthRow = row
        } else if self.basedOnSelectedFLd == 2{
            self.selectedYearRow = row
        }
            else {
        }
       
    }
    
}
