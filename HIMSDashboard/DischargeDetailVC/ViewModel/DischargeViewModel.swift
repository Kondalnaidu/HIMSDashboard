//
//  DischargeViewModel.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 14/11/23.
//
import Foundation
class DischargeViewModel: NSObject {
    func dischargeApi(mainUrl: String, selectedDate:String,success: @escaping([DischargeModel])-> Void, fail: @escaping(_ error: NSError)-> Void) {
        let url = mainUrl+Apis.admissionApi+"\(selectedDate)"
        NetworkManager.shared.fetchObject(url: url, method: .get,parameters: nil,headers: newHeaderss, success: {
            responce in
            success(responce)
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
    func dischargeReportApi(mainUrl: String, selectedDate:String,success: @escaping([DischargeModel])-> Void, fail: @escaping(_ error: NSError)-> Void) {
        let url = mainUrl+Apis.dischargeReportApi+"\(selectedDate)"
        NetworkManager.shared.fetchObject(url: url, method: .get,parameters: nil,headers: newHeaderss, success: {
            responce in
            success(responce)
        }) { error in
            fail(error)
        }
    }
    
    func dischargeWeekWiseApi(mainUrl: String, selectedDate:String,success: @escaping([AdmissionDischargeDetailsWeekModel])-> Void, fail: @escaping(_ error: NSError)-> Void) {
        let url = mainUrl+Apis.admissionDischargeWeekwise+"\(selectedDate)"
        NetworkManager.shared.fetchObject(url: url, method: .get,parameters: nil,headers: newHeaderss, success: {
            responce in
            success(responce)
        }) { error in
            fail(error)
        }
    }

    
}
