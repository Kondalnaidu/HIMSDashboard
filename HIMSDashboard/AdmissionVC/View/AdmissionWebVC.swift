//
//  AdmissionWebVC.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 09/01/24.
//

import UIKit
import WebKit
class AdmissionWebVC: UIViewController, UIDocumentInteractionControllerDelegate {
@IBOutlet weak var headerLbl: UILabel!
@IBOutlet weak var pdfBtn: UIButton!
@IBOutlet weak var webView: WKWebView!
@IBOutlet weak var backBtn: UIButton!
var documentController: UIDocumentInteractionController?
var year = 0
var month = 0
var type = 0
var baseUrl = ""
var pdfUrl = ""
var admissionViewModel = AdmissionViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        documentController?.delegate = self
        backBtn.setTitle("", for: .normal)
        pdfBtn.setTitle("", for: .normal)
        
        if type == 1 {
            self.headerLbl.text = "Discharge Detail"
            
        } else {
            self.headerLbl.text = "Admission Detail"
            
        }
        self.pdfAPi(type: type, year: year, month: month)
        
     }
    
    @IBAction func pdfActBtn(_ sender: UIButton) {
        if let pdfURL = URL(string: self.pdfUrl) {
                   downloadPDF(url: pdfURL)
               }
        
    }
    func downloadPDF(url: URL) {
           URLSession.shared.dataTask(with: url) { (data, response, error) in
               if let data = data {
                   // Save the downloaded PDF to a temporary file
                   let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("Doctor.pdf")
                   do {
                       try data.write(to: tempURL)
                       DispatchQueue.main.async {
                           self.showShareController(with: tempURL)
                       }
                   } catch {
                       print("Error writing PDF to temporary file: \(error.localizedDescription)")
                   }
               } else if let error = error {
                   print("Error downloading PDF: \(error.localizedDescription)")
               }
           }.resume()
       }
    func showShareController(with fileURL: URL) {
            documentController = UIDocumentInteractionController(url: fileURL)
            documentController?.delegate = self

            // Present the share menu
            if let controller = documentController {
                controller.presentOptionsMenu(from: view.bounds, in: view, animated: true)
            }
        }
    private func pdfAPi(type:Int, year: Int, month:Int){
        self.baseUrl = UserDefaults.standard.value(forKey: "claint_Url") as! String
        self.admissionViewModel.pdfApi(pdfApi: Apis.PatientDtlsCash, reportType: type, baseUrl:self.baseUrl , selectedYear: year, selectedType: type, month: month) { responce in
            print(responce)
            self.hideIndicator()
            for dict in responce {
                if dict.status == "Success" {
                    let url = URL(string: dict.url ?? "")
                    self.webView.load(URLRequest(url: url!))
                    self.pdfUrl = dict.url ?? ""
                    if let pdfURL = URL(string: dict.url ?? "") {
                        self.documentController = UIDocumentInteractionController(url: pdfURL)
                    }
                } else {
                    self.showAlert(withTitle: Alert.title, withMessage: "NO DATA FOUND")
                }
               
            }
        } fail: { error in
            print("getting errror")
        }

    }
    
    @IBAction func backActBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
      

}
