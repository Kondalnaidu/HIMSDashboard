//
//  GSTModel.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 18/02/24.
//

import Foundation

struct GSTModel : Codable {
    let taxPer : Float?
    let netAmount : Float?
    let taxAmount : Float?
    let sGSTAmt : Float?
    let cGSTAmt : Float?
    let iGSTAmt : Float?
    let total : Float?
    let discAmount : Float?

    enum CodingKeys: String, CodingKey {

        case taxPer = "TaxPer"
        case netAmount = "NetAmount"
        case taxAmount = "TaxAmount"
        case sGSTAmt = "SGSTAmt"
        case cGSTAmt = "CGSTAmt"
        case iGSTAmt = "IGSTAmt"
        case total = "Total"
        case discAmount = "DiscAmount"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        taxPer = try values.decodeIfPresent(Float.self, forKey: .taxPer)
        netAmount = try values.decodeIfPresent(Float.self, forKey: .netAmount)
        taxAmount = try values.decodeIfPresent(Float.self, forKey: .taxAmount)
        sGSTAmt = try values.decodeIfPresent(Float.self, forKey: .sGSTAmt)
        cGSTAmt = try values.decodeIfPresent(Float.self, forKey: .cGSTAmt)
        iGSTAmt = try values.decodeIfPresent(Float.self, forKey: .iGSTAmt)
        total = try values.decodeIfPresent(Float.self, forKey: .total)
        discAmount = try values.decodeIfPresent(Float.self, forKey: .discAmount)
    }

}

