//
//  AdmissionViewModel.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 15/12/23.
//

import Foundation
class AdmissionViewModel: NSObject {
    func admissionCountApi(baseUrl: String,success:@escaping(([AdmissionModel])-> Void), fail:@escaping((_ error:NSError)-> Void)){
           var url = baseUrl
       print(url)
           url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
           NetworkManager.shared.fetchObject(url: url, method: .get, parameters: nil , headers: newHeaderss, success: { response in
               success(response)
           }) { error in
               fail(error)
           }
        }
    func pdfApi(pdfApi:String,reportType: Int,baseUrl:String,selectedYear:Int,selectedType:Int,month:Int,success:@escaping(([PdfModel])-> Void), fail:@escaping((_ error:NSError)-> Void)){
        var url = baseUrl+pdfApi+"Year=\(selectedYear)&Month=\(month)&Type=\(selectedType)"
        print(url)
        url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        NetworkManager.shared.fetchObject(url: url, method: .get, parameters: nil , headers: newHeaderss, success: { response in
            success(response)
        }) { error in
            fail(error)
        }
    }
       

}
