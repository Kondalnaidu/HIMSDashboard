//
//  DischargeModel.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 14/11/23.
//

import Foundation
struct DischargeModel : Codable {
    let admnCnt : Int?
    let dischrgeCnt : Int?
    let bedCnt : Int?

    enum CodingKeys: String, CodingKey {

        case admnCnt = "AdmnCnt"
        case dischrgeCnt = "DischrgeCnt"
        case bedCnt = "BedCnt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        admnCnt = try values.decodeIfPresent(Int.self, forKey: .admnCnt)
        dischrgeCnt = try values.decodeIfPresent(Int.self, forKey: .dischrgeCnt)
        bedCnt = try values.decodeIfPresent(Int.self, forKey: .bedCnt)
    }

}
struct AdmissionDischargeDetailsWeekModel : Codable {
    let regDate : String?
    let admnCnt : Int?
    let dischrgeCnt : Int?

    enum CodingKeys: String, CodingKey {

        case regDate = "RegDate"
        case admnCnt = "AdmnCnt"
        case dischrgeCnt = "DischrgeCnt"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        regDate = try values.decodeIfPresent(String.self, forKey: .regDate)
        admnCnt = try values.decodeIfPresent(Int.self, forKey: .admnCnt)
        dischrgeCnt = try values.decodeIfPresent(Int.self, forKey: .dischrgeCnt)
    }

}
