//
//  TotalSummeryModel.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 13/11/23.
//

import Foundation
/*
struct TotalSummeryModel : Codable {
    let totCash : Int?
    let totBank : Int?
    let cash : [TotalCash]?
    let bank : [TotalBank]?

    enum CodingKeys: String, CodingKey {

        case totCash = "TotCash"
        case totBank = "TotBank"
        case cash = "Cash"
        case bank = "Bank"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        totCash = try values.decodeIfPresent(Int.self, forKey: .totCash)
        totBank = try values.decodeIfPresent(Int.self, forKey: .totBank)
        cash = try values.decodeIfPresent([TotalCash].self, forKey: .cash)
        bank = try values.decodeIfPresent([TotalBank].self, forKey: .bank)
    }

}
*/
struct TotalSummeryModel : Codable {
    let totCash : Double?
    let totBank : Double?
    let cash : [TotalCash]?
    let bank : [TotalBank]?

    enum CodingKeys: String, CodingKey {

        case totCash = "TotCash"
        case totBank = "TotBank"
        case cash = "Cash"
        case bank = "Bank"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        totCash = try values.decodeIfPresent(Double.self, forKey: .totCash)
        totBank = try values.decodeIfPresent(Double.self, forKey: .totBank)
        cash = try values.decodeIfPresent([TotalCash].self, forKey: .cash)
        bank = try values.decodeIfPresent([TotalBank].self, forKey: .bank)
    }

}

struct TotalCash : Codable {
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
struct TotalBank : Codable {
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

/*
 struct TotalCash : Codable {
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
 
 struct TotalBank : Codable {
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
 */
