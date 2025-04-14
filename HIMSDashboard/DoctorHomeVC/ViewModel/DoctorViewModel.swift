//
//  DoctorViewModel.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 12/08/23.
//

import Foundation
class DoctorViewModel: NSObject {
    func homeScreensummmerApi(baseUrl:String,selectedDate:String,success:@escaping(([DoctorHomeModel])-> Void), fail:@escaping((_ error:NSError)-> Void)){
           var url = baseUrl+Apis.homeSummerApi+"\(selectedDate)"
       print(url)
           url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
           NetworkManager.shared.fetchObject(url: url, method: .get, parameters: nil , headers: newHeaderss, success: { response in
               success(response)
           }) { error in
               fail(error)
           }
        }
    
func dashBoardPatientAPi(baseUrl:String,selectedDate:String,success:@escaping(([DashBoardpatientModel])-> Void), fail:@escaping((_ error:NSError)-> Void)){
           var url = baseUrl+Apis.patientCountApi+"\(selectedDate)"
       print(url)
           url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
           NetworkManager.shared.fetchObject(url: url, method: .get, parameters: nil , headers: newHeaderss, success: { response in
               success(response)
           }) { error in
               fail(error)
           }
        }
func dashBoardAdmissionAPi(baseUrl:String,selectedDate:String,success:@escaping(([DashBoardAdmissionModel])-> Void), fail:@escaping((_ error:NSError)-> Void)){
           var url = baseUrl+Apis.admissionApi+"\(selectedDate)"
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
