//
//  PdfViewModel.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 14/11/23.
//

import Foundation
import Foundation
class PdfViewModel: NSObject {
func pdfApi(reportApi:String,reportType: String,baseUrl:String,selectedDate:String,success:@escaping(([PdfModel])-> Void), fail:@escaping((_ error:NSError)-> Void)){
    var url = baseUrl+reportApi+"\(selectedDate)&Reporttype=\(reportType)"
    print(url)
    url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    NetworkManager.shared.fetchObject(url: url, method: .get, parameters: nil , headers: newHeaderss, success: { response in
        success(response)
    }) { error in
        fail(error)
    }
}
    
    func dischargePdfApi(reportApi:String,baseUrl:String,selectedDate:String,success:@escaping(([PdfModel])-> Void), fail:@escaping((_ error:NSError)-> Void)){
        var url = baseUrl+reportApi+"\(selectedDate)"
        print(url)
        url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        NetworkManager.shared.fetchObject(url: url, method: .get, parameters: nil , headers: newHeaderss, success: { response in
            success(response)
        }) { error in
            fail(error)
        }
    }

}
