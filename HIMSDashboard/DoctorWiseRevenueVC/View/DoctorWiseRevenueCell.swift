//
//  DoctorWiseRevenueCell.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 02/11/23.
//

import UIKit
import DGCharts
import Charts
protocol doctorwiseProtocol: NSObject {
    func getdataMothwise(docId:Int, Year: Int)
}
class DoctorWiseRevenueCell: UITableViewCell {
    @IBOutlet weak var barchatView: BarChartView!
    @IBOutlet weak var doctorNameField: UITextField!
    @IBOutlet weak var pharmacyView: UIView!
    @IBOutlet weak var yearFld: UITextField!
    @IBOutlet weak var dpView: UIView!
    @IBOutlet weak var ipView: UIView!
    @IBOutlet weak var allView: UIView!
    @IBOutlet weak var pharmcyBtn: UIButton!
    @IBOutlet weak var dpBtn: UIButton!
    @IBOutlet weak var ipbtn: UIButton!
    @IBOutlet weak var opBtn: UIButton!
    @IBOutlet weak var allBtn: UIButton!
    @IBOutlet weak var opView: UIView!
    @IBOutlet weak var pharmcyCheckImageView: UIImageView!
    @IBOutlet weak var dpCheckImageView: UIImageView!
    @IBOutlet weak var opCheckImageView: UIImageView!
    @IBOutlet weak var ipCheckImageView: UIImageView!
    @IBOutlet weak var allCheckImageView: UIImageView!
    var doctorNamesArray = [AdmissionDoctorsModel]()//[String]()
    lazy var years: [Int] = {
        let currentYear = Calendar.current.component(.year, from: Date())
        return Array((currentYear - 100)...currentYear).reversed() // Adjust the range as needed
    }()
    var basedOnSelectedFLd = 0
    var delegate: doctorwiseProtocol?
    var selectedDoctorNameRow = 0
    var selectedYearRow = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        yearFld.delegate = self
        doctorNameField.delegate = self
        self.allBtn.setTitle("", for: .normal)
        self.opBtn.setTitle("", for: .normal)
        self.ipbtn.setTitle("", for: .normal)
        self.dpBtn.setTitle("", for: .normal)
        self.pharmcyBtn.setTitle("", for: .normal)
        
        self.allView.layer.cornerRadius = 4
        self.opView.layer.cornerRadius = 4
        self.ipView.layer.cornerRadius = 4
        self.dpView.layer.cornerRadius = 4
        self.pharmacyView.layer.cornerRadius = 4
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
            doctorNameField.resignFirstResponder()

        } else {
            yearFld.resignFirstResponder()

        }
    }
    @objc func doneButtonPressed(sender:UIButton) {
        if self.basedOnSelectedFLd == 1 {
             for dict in self.doctorNamesArray {
                let name = dict.docName
                if self.doctorNameField.text == name {
                    self.doctorNameField.text = name
                }
            }
            self.doctorNameField.text = self.doctorNamesArray[selectedDoctorNameRow].docName
            doctorNameField.resignFirstResponder()
             
         } else {
             self.yearFld.text = "\(self.years[selectedYearRow])"
             print("SelectedYear from selected picker",self.years[selectedYearRow])
            yearFld.resignFirstResponder()
        }
        
    }
}
    extension DoctorWiseRevenueCell: UITextFieldDelegate{
        func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
            if textField == doctorNameField {
                self.basedOnSelectedFLd = 1
                self.setupPickerView(fld:doctorNameField)
                
            } else {
                self.basedOnSelectedFLd = 2
                self.setupPickerView(fld: yearFld)
            }
            return true
        }
    }
    
    extension DoctorWiseRevenueCell: UIPickerViewDelegate, UIPickerViewDataSource {
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1//
        }
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            if basedOnSelectedFLd == 1 {
                return self.doctorNamesArray.count
            } else {
                return self.years.count
            }
        }
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            if self.basedOnSelectedFLd == 1 {
                return self.doctorNamesArray[row].docName
            } else {
                return "\(self.years[row])"
            }
        }
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            if self.basedOnSelectedFLd == 1 {
                // let indexPath = IndexPath(row: 0, section: 0)
                //let cell = tableView.cellForRow(at: indexPath) as! DoctorWiseRevenueCell
                doctorNameField.text = self.doctorNamesArray[row].docName
                print(self.doctorNamesArray[row].docId)
                 
            } else {
                yearFld.text = "\(self.years[row])"
                self.selectedYearRow = row

            }
            self.selectedDoctorNameRow = row
        }
        
    }
 
