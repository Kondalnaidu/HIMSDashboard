//
//  ExpendutureViewModel.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 14/11/23.
//

import Foundation

class ExpendutureViewModel: NSObject {
    func expenditureApi(reportApi:String, baseUrl:String,selectedDate:String,success:@escaping((ExpendutureModel)-> Void), fail:@escaping((_ error:NSError)-> Void)){
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
