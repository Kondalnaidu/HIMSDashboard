//
//  PdfVC.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 14/11/23.
//

import UIKit
import WebKit
import PDFKit
class PdfVC: BaseViewContrller, UIDocumentInteractionControllerDelegate {
    @IBOutlet weak var headerLbl: UILabel!
    
    @IBOutlet weak var pdfBtn: UIButton!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var webView: WKWebView!
    var pdfViewModel = PdfViewModel()
    var claintAPi = ""
    var reportType = ""
    var selectedDate = ""//Date().getZeroTime()
    var clickFrom = ""
    var documentController: UIDocumentInteractionController?
    var textMessage: String = ""
var pdfUrl = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        documentController?.delegate = self
        
        self.pdfBtn.setTitle("", for: .normal)
        self.showIndicator()
        if self.clickFrom == "Discharge" {
            self.dischargeReportApi(reportApi: Apis.dischargeReportApi, date: self.selectedDate)
        } else if self.clickFrom == "Admission" {
            self.dischargeReportApi(reportApi: Apis.admissionReportApi, date: self.selectedDate)
        } else if self.clickFrom == "Occupancy" {
            self.dischargeReportApi(reportApi: Apis.occupancyReportApi, date: "")
        } else if self.clickFrom == "inDetails" {
            self.reportAPi(reportType: self.reportType, reportApi: Apis.ipReportApi)
            
        } else if self.clickFrom == "opDetails" {
            self.reportAPi(reportType: self.reportType, reportApi: Apis.opReportAPi)
            
        } else if self.clickFrom == "pharmacyDetail" {
            self.reportAPi(reportType: self.reportType, reportApi: Apis.pharmacyReport)
        } else if self.clickFrom == "diagonsticDetail" {
            self.reportAPi(reportType: self.reportType, reportApi: Apis.diagoReports)
            
        }
        print(reportType)
        
        self.backBtn.setTitle("", for: .normal)
        
        let swipeGestureRecognizerDown = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
        swipeGestureRecognizerDown.direction = .right
        self.view.addGestureRecognizer(swipeGestureRecognizerDown)
        
        
        
        
        
        
    }
    
    func createPDF(from content: String) -> Data? {
            let pdfData = NSMutableData()

            UIGraphicsBeginPDFContextToData(pdfData, CGRect.zero, nil)

            UIGraphicsBeginPDFPage()
            let textFont = UIFont.systemFont(ofSize: 12.0)
            let textAttributes = [NSAttributedString.Key.font: textFont]

            let textRect = CGRect(x: 20, y: 20, width: 300, height: 500)
            content.draw(in: textRect, withAttributes: textAttributes)

            UIGraphicsEndPDFContext()

            return pdfData as Data
        }
     


    func savePDF(pdfData: Data, fileName: String) {
           guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
           let path = documentDirectory.appendingPathComponent("\(fileName).pdf")
           
           do {
               try pdfData.write(to: path)
               print("PDF saved at: \(path)")
               sharePDF(pdfData: pdfData, fileName: "SamplePDF")

           } catch {
               print("Error saving PDF: \(error.localizedDescription)")
           }
       }

    
    func sharePDF(pdfData: Data, fileName: String) {
           let activityViewController = UIActivityViewController(activityItems: [pdfData], applicationActivities: nil)
           activityViewController.popoverPresentationController?.sourceView = self.view
           present(activityViewController, animated: true, completion: nil)
       }
    
    
   

//    func enterTextViaAlert(){
//
//        let alert = UIAlertController(title: "Enter Text", message: "Please enter text to convert it in PDF file.", preferredStyle: UIAlertController.Style.alert)
//
//        alert.addTextField { (textField) in
//          //  textField.delegate = self
//        }
//
//        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//        alert.addAction(UIAlertAction(title: "Convert", style: .default, handler: {_ in
//            self.view.endEditing(true)
//            guard self.textMessage.count>0 else {
//                let alert = UIAlertController(title: "", message: "Please enter text to convert it in PDF file.", preferredStyle: UIAlertController.Style.alert)
//                alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//                return
//            }
//
//            self.convertToPdfFileAndShare()
//
//        }))
//
//        self.present(alert, animated: true, completion: nil)
//
//    }
//
//    func convertToPdfFileAndShare(){
//
//        let fmt = UIMarkupTextPrintFormatter(markupText: "https://app.athentech.in/AppHDB/ParamithaKPT/iTextReports/20231116_S31UOU9S.pdf")
//
//        // 2. Assign print formatter to UIPrintPageRenderer
//        let render = UIPrintPageRenderer()
//        render.addPrintFormatter(fmt, startingAtPageAt: 0)
//
//        // 3. Assign paperRect and printableRect
//        let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
//        render.setValue(page, forKey: "paperRect")
//        render.setValue(page, forKey: "printableRect")
//
//        // 4. Create PDF context and draw
//        let pdfData = NSMutableData()
//        UIGraphicsBeginPDFContextToData(pdfData, .zero, nil)
//
//        for i in 0..<render.numberOfPages {
//            UIGraphicsBeginPDFPage();
//            render.drawPage(at: i, in: UIGraphicsGetPDFContextBounds())
//        }
//
//        UIGraphicsEndPDFContext();
//
//        // 5. Save PDF file
//        guard let outputURL = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("output").appendingPathExtension("pdf")
//            else { fatalError("Destination URL not created") }
//
//        pdfData.write(to: outputURL, atomically: true)
//        print("open \(outputURL.path)")
//
//        if FileManager.default.fileExists(atPath: outputURL.path){
//
//            let url = URL(fileURLWithPath: outputURL.path)
//            let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
//            activityViewController.popoverPresentationController?.sourceView = self.view
//
//            //If user on iPad
////            if UIDevice.current.userInterfaceIdiom == .phone {
////                if activityViewController.responds(to: #selector(getter: UIViewController.popoverPresentationController)) {
////                }
////            }
//            present(activityViewController, animated: true, completion: nil)
//
//        }
//        else {
//            print("document was not found")
//        }
//
//    }

    
    @IBAction func pdfShareActBtn(_ sender: UIButton) {
        
        
        if let pdfURL = URL(string: self.pdfUrl) {
                   downloadPDF(url: pdfURL)
               }
        
      //  let contentString = "https://app.athentech.in/AppHDB/ParamithaKPT/iTextReports/20231116_S31UOU9S.pdf"
        //
        //                // Create PDF data from the string
       // if let pdfData = createPDF(from: contentString) {
            //                    // Save the PDF file
        //    savePDF(pdfData: pdfData, fileName: "SamplePDF")
            //
            //                    // Share the PDF file
            //                }
            
            // self.enterTextViaAlert()
            //  self.convertToPdfFileAndShare()
            
            //        if let controller = documentController {
            //                    controller.presentOptionsMenu(from: view.bounds, in: view, animated: true)
            //                }
       // }
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
    
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
            return self
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
    private func reportAPi(reportType:String, reportApi:String){
        self.pdfViewModel.pdfApi(reportApi: reportApi, reportType: reportType, baseUrl: self.claintAPi, selectedDate:self.selectedDate) { responce in
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
    
    private func dischargeReportApi(reportApi:String,date:String){
        self.pdfViewModel.dischargePdfApi(reportApi: reportApi, baseUrl: self.claintAPi, selectedDate: date) { responce in
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
                    self.showAlert(withTitle: Alert.title, withMessage: "We dont have PDF")
                }
               
            }
         } fail: { error in
            print("getting error")
        }


    }

    private func getTimeFormate(date: Date)-> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYY-MM-dd"
        let dateString = dateFormatter.string(from: date)
        return dateString
    }
     
    @IBAction func backActBtn(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
     
    
    
}
    

    

