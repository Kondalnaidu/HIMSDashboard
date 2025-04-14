//
//  FinanceGlanceModel.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 02/11/23.
//

import Foundation
struct FinanceGlanceModel : Codable {
    let dtls : [FinanceGlanceDetailDtls]?
    let totSummary : [FinanceGlanceDetailTotSummary]?

    enum CodingKeys: String, CodingKey {

        case dtls = "Dtls"
        case totSummary = "totSummary"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        dtls = try values.decodeIfPresent([FinanceGlanceDetailDtls].self, forKey: .dtls)
        totSummary = try values.decodeIfPresent([FinanceGlanceDetailTotSummary].self, forKey: .totSummary)
    }


}
struct FinanceGlanceDetailTotSummary : Codable {
    let tTYPE : String?
    let aMT : Double?

    enum CodingKeys: String, CodingKey {

        case tTYPE = "TTYPE"
        case aMT = "AMT"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tTYPE = try values.decodeIfPresent(String.self, forKey: .tTYPE)
        aMT = try values.decodeIfPresent(Double.self, forKey: .aMT)
    }

}
struct FinanceGlanceDetailDtls : Codable {
    let tTYPE : String?
    let cNT : Double?
    let aMT : Double?

    enum CodingKeys: String, CodingKey {

        case tTYPE = "TTYPE"
        case cNT = "CNT"
        case aMT = "AMT"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tTYPE = try values.decodeIfPresent(String.self, forKey: .tTYPE)
        cNT = try values.decodeIfPresent(Double.self, forKey: .cNT)
        aMT = try values.decodeIfPresent(Double.self, forKey: .aMT)
    }
}
