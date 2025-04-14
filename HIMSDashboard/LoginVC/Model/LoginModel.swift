//
//  LoginModel.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 16/08/23.
//

import Foundation
//struct LoginModel: Codable {
//      let url: String?
//      let STATUS: String?
//
//     enum CodingKeys: String,CodingKey {
//         case url = "url"
//         case Status = "STATUS"
//
//     }
//}
struct LoginModel : Codable {
    let uID : Int?
    let uSERID : String?
    let pWORD : String?
    let aCTIVE : Bool?
    let uCODE : String?
    let isAdmin : Bool?
    let isPharm : Bool?
    let isDiag : Bool?
    let uSERNAME : String?
    let sTATUS : String?
    let url: String?

    enum CodingKeys: String, CodingKey {

        case uID = "UID"
        case uSERID = "USERID"
        case pWORD = "PWORD"
        case aCTIVE = "ACTIVE"
        case uCODE = "UCODE"
        case isAdmin = "IsAdmin"
        case isPharm = "isPharm"
        case isDiag = "isDiag"
        case uSERNAME = "USERNAME"
        case sTATUS = "STATUS"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        uID = try values.decodeIfPresent(Int.self, forKey: .uID)
        uSERID = try values.decodeIfPresent(String.self, forKey: .uSERID)
        pWORD = try values.decodeIfPresent(String.self, forKey: .pWORD)
        aCTIVE = try values.decodeIfPresent(Bool.self, forKey: .aCTIVE)
        uCODE = try values.decodeIfPresent(String.self, forKey: .uCODE)
        isAdmin = try values.decodeIfPresent(Bool.self, forKey: .isAdmin)
        isPharm = try values.decodeIfPresent(Bool.self, forKey: .isPharm)
        isDiag = try values.decodeIfPresent(Bool.self, forKey: .isDiag)
        uSERNAME = try values.decodeIfPresent(String.self, forKey: .uSERNAME)
        sTATUS = try values.decodeIfPresent(String.self, forKey: .sTATUS)
        url = try values.decodeIfPresent(String.self, forKey: .url)

    }

}
