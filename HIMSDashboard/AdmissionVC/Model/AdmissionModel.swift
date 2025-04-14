//
//  AdmissionModel.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 15/12/23.
//

import Foundation
struct AdmissionModel : Codable {
    let monthNM : String?
    let admnCnt : Int?
    let dischCnt : Int?

    enum CodingKeys: String, CodingKey {

        case monthNM = "MonthNM"
        case admnCnt = "AdmnCnt"
        case dischCnt = "DischCnt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        monthNM = try values.decodeIfPresent(String.self, forKey: .monthNM)
        admnCnt = try values.decodeIfPresent(Int.self, forKey: .admnCnt)
        dischCnt = try values.decodeIfPresent(Int.self, forKey: .dischCnt)
    }

}
