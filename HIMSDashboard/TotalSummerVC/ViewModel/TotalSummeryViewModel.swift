//
//  TotalSummeryViewModel.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 13/11/23.
//

import Foundation
class TotalSummeryViewModel: NSObject {
    func totalSummeryAPi(glananceDetailApi:String,url: String,selectedDate:String, success:@escaping(TotalSummeryModel)->Void,fail:@escaping(_ error: NSError)-> Void){
        var url = url+glananceDetailApi+"\(selectedDate)"
    print(url)
        url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        NetworkManager.shared.fetchObject(url: url, method: .get,parameters: nil, headers: newHeaderss, success: { responce in
            success(responce)
        }) { error in
            fail(error)
        }
    }
}
