//
//  GSTMonthlyModel.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 20/02/24.
//

import Foundation
struct GSTMonthlyModel : Codable {
    let sALEDT : String?
    let taxable0 : Float?
    let taxable5 : Float?
    let gST5 : Float?
    let taxable12 : Float?
    let gST12 : Float?
    let taxable18 : Float?
    let gST18 : Float?
    let taxable28 : Float?
    let gST28 : Float?

    enum CodingKeys: String, CodingKey {

        case sALEDT = "SALEDT"
        case taxable0 = "Taxable0"
        case taxable5 = "Taxable5"
        case gST5 = "GST5"
        case taxable12 = "Taxable12"
        case gST12 = "GST12"
        case taxable18 = "Taxable18"
        case gST18 = "GST18"
        case taxable28 = "Taxable28"
        case gST28 = "GST28"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        sALEDT = try values.decodeIfPresent(String.self, forKey: .sALEDT)
        taxable0 = try values.decodeIfPresent(Float.self, forKey: .taxable0)
        taxable5 = try values.decodeIfPresent(Float.self, forKey: .taxable5)
        gST5 = try values.decodeIfPresent(Float.self, forKey: .gST5)
        taxable12 = try values.decodeIfPresent(Float.self, forKey: .taxable12)
        gST12 = try values.decodeIfPresent(Float.self, forKey: .gST12)
        taxable18 = try values.decodeIfPresent(Float.self, forKey: .taxable18)
        gST18 = try values.decodeIfPresent(Float.self, forKey: .gST18)
        taxable28 = try values.decodeIfPresent(Float.self, forKey: .taxable28)
        gST28 = try values.decodeIfPresent(Float.self, forKey: .gST28)
    }

}
