//
//  GSTsummaryViewModel.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 18/02/24.
//

import Foundation
class GSTsummaryViewModel: NSObject {
    func gstSummaryApi(baseUrl: String,success:@escaping(([GSTModel])-> Void), fail:@escaping((_ error:NSError)-> Void)){
           var url = baseUrl
       print(url)
           url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
           NetworkManager.shared.fetchObject(url: url, method: .get, parameters: nil , headers: newHeaderss, success: { response in
               success(response)
           }) { error in
               fail(error)
           }
        }
}
