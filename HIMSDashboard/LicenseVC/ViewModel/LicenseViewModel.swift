//
//  LicenseViewModel.swift
//  HIMSDashboard
//
//  Created by ATHENTECH INDIA on 20/07/23.
//

import Foundation
import UIKit
class LicenseViewModel : NSObject {
    func licenseAPi(key: String, success:@escaping(([LicenseModel])-> Void), fail:@escaping((_ error:NSError)-> Void)){
           var url = Apis.licenseApi+"\(key)"//9WYT84LG
       print(url)
           url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
           NetworkManager.shared.fetchObject(url: url, method: .get, parameters: nil , headers: newHeaderss, success: { response in
               success(response)
           }) { error in
               fail(error)
           }
        }
}
