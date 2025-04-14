//
//  DoctorHomeModel.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 12/08/23.
//

import Foundation//DoctorHomeModel
/*
struct DoctorHomeModel : Codable {
    let oPFinGlance : Int?
    let iPFinGlance : Double?
    let diagFinGlance : Int?
    let phamaFinGlance : Int?
    let totalFinGlance : Double?
    let expenditure : Int?

    enum CodingKeys: String, CodingKey {

        case oPFinGlance = "OPFinGlance"
        case iPFinGlance = "IPFinGlance"
        case diagFinGlance = "DiagFinGlance"
        case phamaFinGlance = "PhamaFinGlance"
        case totalFinGlance = "TotalFinGlance"
        case expenditure = "Expenditure"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        oPFinGlance = try values.decodeIfPresent(Int.self, forKey: .oPFinGlance)
        iPFinGlance = try values.decodeIfPresent(Double.self, forKey: .iPFinGlance)
        diagFinGlance = try values.decodeIfPresent(Int.self, forKey: .diagFinGlance)
        phamaFinGlance = try values.decodeIfPresent(Int.self, forKey: .phamaFinGlance)
        totalFinGlance = try values.decodeIfPresent(Double.self, forKey: .totalFinGlance)
        expenditure = try values.decodeIfPresent(Int.self, forKey: .expenditure)
    }

}
 */
struct DoctorHomeModel : Codable {
    let oPFinGlance : Int?
    let iPFinGlance : Double?
    let diagFinGlance : Int?
    let phamaFinGlance : Double?
    let totalFinGlance : Double?
    let expenditure : Int?

    enum CodingKeys: String, CodingKey {

        case oPFinGlance = "OPFinGlance"
        case iPFinGlance = "IPFinGlance"
        case diagFinGlance = "DiagFinGlance"
        case phamaFinGlance = "PhamaFinGlance"
        case totalFinGlance = "TotalFinGlance"
        case expenditure = "Expenditure"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        oPFinGlance = try values.decodeIfPresent(Int.self, forKey: .oPFinGlance)
        iPFinGlance = try values.decodeIfPresent(Double.self, forKey: .iPFinGlance)
        diagFinGlance = try values.decodeIfPresent(Int.self, forKey: .diagFinGlance)
        phamaFinGlance = try values.decodeIfPresent(Double.self, forKey: .phamaFinGlance)
        totalFinGlance = try values.decodeIfPresent(Double.self, forKey: .totalFinGlance)
        expenditure = try values.decodeIfPresent(Int.self, forKey: .expenditure)
    }

}
struct DashBoardpatientModel : Codable {
    let NewPatCnt : Int?
    let RVPatCnt : Int?
     

    enum CodingKeys: String, CodingKey {

        case NewPatCnt = "NewPatCnt"
        case RVPatCnt = "RVPatCnt"
         
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        NewPatCnt = try values.decodeIfPresent(Int.self, forKey: .NewPatCnt)
        RVPatCnt = try values.decodeIfPresent(Int.self, forKey: .RVPatCnt)

         
    }

}

struct DashBoardAdmissionModel : Codable {
    let AdmnCnt : Int?
    let DischrgeCnt : Int?
    let BedCnt: Int?
     

    enum CodingKeys: String, CodingKey {

        case AdmnCnt = "AdmnCnt"
        case DischrgeCnt = "DischrgeCnt"
        case BedCnt = "BedCnt"

         
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        AdmnCnt = try values.decodeIfPresent(Int.self, forKey: .AdmnCnt)
        DischrgeCnt = try values.decodeIfPresent(Int.self, forKey: .DischrgeCnt)
        BedCnt = try values.decodeIfPresent(Int.self, forKey: .BedCnt)


         
    }

}
struct WeeklySummerDetailModel : Codable {
    let paidDate : String?
    let oP : Int?
    let iP : Int?
    let diag : Int?
    let pharmacy : Int?
    let total : Int?

    enum CodingKeys: String, CodingKey {

        case paidDate = "PaidDate"
        case oP = "OP"
        case iP = "IP"
        case diag = "Diag"
        case pharmacy = "Pharmacy"
        case total = "Total"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        paidDate = try values.decodeIfPresent(String.self, forKey: .paidDate)
        oP = try values.decodeIfPresent(Int.self, forKey: .oP)
        iP = try values.decodeIfPresent(Int.self, forKey: .iP)
        diag = try values.decodeIfPresent(Int.self, forKey: .diag)
        pharmacy = try values.decodeIfPresent(Int.self, forKey: .pharmacy)
        total = try values.decodeIfPresent(Int.self, forKey: .total)
    }

}
