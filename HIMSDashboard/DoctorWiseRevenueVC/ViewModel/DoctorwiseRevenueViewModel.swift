//
//  DoctorwiseRevenueViewModel.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 15/12/23.
//
//https://app.athentech.in/AppHDB/ParamithaKPT/DoctorwiseRevenue?docId=1&Year=2023&Type=OP

import Foundation
class DoctorwiseRevenueViewModel: NSObject {
    func admissionDoctorsApi(success:@escaping(([AdmissionDoctorsModel])-> Void), fail:@escaping((_ error:NSError)-> Void)){
           var url = Apis.getDoctors
       print(url)
           url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
           NetworkManager.shared.fetchObject(url: url, method: .get, parameters: nil , headers: newHeaderss, success: { response in
               success(response)
           }) { error in
               fail(error)
           }
        }
    func doctorwiseRevenueAPi(baseUrl: String,success:@escaping(([DoctorRevenueModel])-> Void), fail:@escaping((_ error:NSError)-> Void)){
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
