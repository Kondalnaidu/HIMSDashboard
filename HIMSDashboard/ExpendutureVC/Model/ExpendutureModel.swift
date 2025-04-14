//
//  ExpendutureModel.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 14/11/23.
//

import Foundation
struct ExpendutureModel : Codable {
    let dtls : [ExpendutureDtls]?
    let totSummary : [ExpendutureTotSummary]?

    enum CodingKeys: String, CodingKey {

        case dtls = "Dtls"
        case totSummary = "totSummary"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dtls = try values.decodeIfPresent([ExpendutureDtls].self, forKey: .dtls)
        totSummary = try values.decodeIfPresent([ExpendutureTotSummary].self, forKey: .totSummary)
    }

}
struct ExpendutureDtls : Codable {
    let tTYPE : String?
    let cNT : Int?
    let aMT : Int?

    enum CodingKeys: String, CodingKey {

        case tTYPE = "TTYPE"
        case cNT = "CNT"
        case aMT = "AMT"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tTYPE = try values.decodeIfPresent(String.self, forKey: .tTYPE)
        cNT = try values.decodeIfPresent(Int.self, forKey: .cNT)
        aMT = try values.decodeIfPresent(Int.self, forKey: .aMT)
    }

}
struct ExpendutureTotSummary : Codable {
    let tTYPE : String?
    let aMT : Int?

    enum CodingKeys: String, CodingKey {

        case tTYPE = "TTYPE"
        case aMT = "AMT"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tTYPE = try values.decodeIfPresent(String.self, forKey: .tTYPE)
        aMT = try values.decodeIfPresent(Int.self, forKey: .aMT)
    }

}
