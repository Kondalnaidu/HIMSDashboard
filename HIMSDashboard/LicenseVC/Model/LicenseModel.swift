//
//  LicenseModel.swift
//  HIMSDashboard
//
//  Created by ATHENTECH INDIA on 20/07/23.
//

import Foundation
struct LicenseModel : Codable {
    let licenseKey : String?
    let clientName : String?
    let clientURL : String?
    let logoURL : String?
    let expDate : String?
    let status : String?
    let clientType : String?

    enum CodingKeys: String, CodingKey {

        case licenseKey = "LicenseKey"
        case clientName = "ClientName"
        case clientURL = "ClientURL"
        case logoURL = "LogoURL"
        case expDate = "ExpDate"
        case status = "Status"
        case clientType = "ClientType"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        licenseKey = try values.decodeIfPresent(String.self, forKey: .licenseKey)
        clientName = try values.decodeIfPresent(String.self, forKey: .clientName)
        clientURL = try values.decodeIfPresent(String.self, forKey: .clientURL)
        logoURL = try values.decodeIfPresent(String.self, forKey: .logoURL)
        expDate = try values.decodeIfPresent(String.self, forKey: .expDate)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        clientType = try values.decodeIfPresent(String.self, forKey: .clientType)
    }

}
