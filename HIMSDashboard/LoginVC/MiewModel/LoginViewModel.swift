//
//  LoginViewModel.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 15/08/23.
//

import Foundation
class LoginViewModel: NSObject {
    func loginApi(baseUrl:String,userName: String,password:String, success:@escaping(([LoginModel])-> Void), fail:@escaping((_ error:NSError)-> Void)){
           var url =  baseUrl+Apis.loginApi+"UserId=\(userName)&Password=\(password)"//9WYT84LG
       print(url)
           url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
           NetworkManager.shared.fetchObject(url: url, method: .get, parameters: nil , headers: newHeaderss, success: { response in
               success(response)
           }) { error in
               fail(error)
           }
        }


}
