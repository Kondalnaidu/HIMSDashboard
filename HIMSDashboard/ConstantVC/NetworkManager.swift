//
//  NetworkManager.swift
//  HIMSDashboard
//
//  Created by ATHENTECH INDIA on 20/07/23.
//

import Foundation
import Alamofire
class NetworkManager {
    
    static let shared = NetworkManager()
    var afManager : Session!
    
    func initFunc() {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringCacheData
        afManager = Session()
    }
        /*
func fetchObject<T: Decodable>(url: String,
                                   method: HTTPMethod = .post,
                                   parameters: Parameters? = nil,
                                   headers: HTTPHeaders? = nil,
                                   encoding: ParameterEncoding = JSONEncoding.default,
                                   success: @escaping (T) -> Void,
                                   fail: @escaping (Error) -> Void) {
        
        AF.request(url,
                   method: method,
                   parameters: parameters,
                   encoding: encoding,
                   headers: headers)
            .validate() // Validate the response, removing the need for an explicit success check
            .responseDecodable(of: T.self) { response in
                switch response.result {
                case .success(let responseObject):
                    success(responseObject)
                    
                case .failure(let error):
                    fail(error)
                }
            }
    }
   */
    func fetchObject<T: Codable>(url:String,
                                 method: HTTPMethod = .post,
                                 parameters: Parameters?,
                                 headers: HTTPHeaders?,
                                 encoding: ParameterEncoding = JSONEncoding.default, success:@escaping(T)->Void, fail:@escaping(_ error: NSError)->Void) ->Void {
        print(headers)
       // printJson(parameters)
        print("Url: \(url)")
        AF.request(url, method: method,
                          parameters: parameters,
                          encoding: encoding,
                          headers: headers).responseJSON { response in
                            
            switch response.result {
            case .success: do {
                
                let data = response.data
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: Any] {
                        print("Response: \(json)")
                    }
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: Any]] {
                        print("Response: \(json)")
                    }
                    let responseObject = try JSONDecoder().decode(T.self, from: data!)
                    success(responseObject)
                    
                 } catch {
                    print(error)
                    fail(error as NSError)
                  }
                }
            case .failure(let error):
                fail(error as NSError)
            }
          }
    }
   
}
