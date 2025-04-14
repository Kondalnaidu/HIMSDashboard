//
//  FinanceGlanceViewModel.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 02/11/23.
//

import Foundation
class FinanceGlanceViewModel: NSObject {
    func opDetailsAPi(glananceDetailApi:String,baseUrl:String,selectedDate:String,success:@escaping((FinanceGlanceModel)-> Void), fail:@escaping((_ error:NSError)-> Void)){
           var url = baseUrl+glananceDetailApi+"\(selectedDate)"
       print(url)
           url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
           NetworkManager.shared.fetchObject(url: url, method: .get, parameters: nil , headers: newHeaderss, success: { response in
               success(response)
           }) { error in
               fail(error)
           }
        }
    
    func dashBoardAWeekSummerAPi(baseUrl:String,selectedDate:String,success:@escaping(([WeeklySummerDetailModel])-> Void), fail:@escaping((_ error:NSError)-> Void)){
               var url = baseUrl+Apis.weeklySummerDetailApi+"\(selectedDate)"
           print(url)
               url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
               NetworkManager.shared.fetchObject(url: url, method: .get, parameters: nil , headers: newHeaderss, success: { response in
                   success(response)
               }) { error in
                   fail(error)
               }
            }

}
