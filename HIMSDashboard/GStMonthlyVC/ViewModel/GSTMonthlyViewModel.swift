//
//  GSTMonthlyViewModel.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 20/02/24.
//

import Foundation
class GSTMonthlyViewModel: NSObject {
    func gstSummaryApi(baseUrl: String,success:@escaping(([GSTMonthlyModel])-> Void), fail:@escaping((_ error:NSError)-> Void)){
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
