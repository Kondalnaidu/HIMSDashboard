//
//  DoctorwiseRevenueModel.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 15/12/23.
//

import Foundation
struct AdmissionDoctorsModel : Codable {
    let docId : Int?
    let docName : String?

    enum CodingKeys: String, CodingKey {

        case docId = "DocId"
        case docName = "DocName"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        docId = try values.decodeIfPresent(Int.self, forKey: .docId)
        docName = try values.decodeIfPresent(String.self, forKey: .docName)
    }

}

struct DoctorRevenueModel : Codable {
    let doctorRevenue : [DoctorRevenue]?
    let tType : String?

    enum CodingKeys: String, CodingKey {

        case doctorRevenue = "DoctorRevenue"
        case tType = "TType"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        doctorRevenue = try values.decodeIfPresent([DoctorRevenue].self, forKey: .doctorRevenue)
        tType = try values.decodeIfPresent(String.self, forKey: .tType)
    }

}
struct DoctorRevenue : Codable {
    var january2023 : Float?
    var february2023 : Float?
    var march2023 : Float?
    var april2023 : Float?
    var may2023 : Float?
    var june2023 : Float?
    var july2023 : Float?
    var august2023 : Float?
    var september2023 : Float?
    var october2023 : Float?
    var november2023 : Float?
    var december2023 : Float?

    enum CodingKeys: String, CodingKey {

        case january2023 = "January-2023"
        case february2023 = "February-2023"
        case march2023 = "March-2023"
        case april2023 = "April-2023"
        case may2023 = "May-2023"
        case june2023 = "June-2023"
        case july2023 = "July-2023"
        case august2023 = "August-2023"
        case september2023 = "September-2023"
        case october2023 = "October-2023"
        case november2023 = "November-2023"
        case december2023 = "December-2023"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        january2023 = try values.decodeIfPresent(Float.self, forKey: .january2023)
        february2023 = try values.decodeIfPresent(Float.self, forKey: .february2023)
        march2023 = try values.decodeIfPresent(Float.self, forKey: .march2023)
        april2023 = try values.decodeIfPresent(Float.self, forKey: .april2023)
        may2023 = try values.decodeIfPresent(Float.self, forKey: .may2023)
        june2023 = try values.decodeIfPresent(Float.self, forKey: .june2023)
        july2023 = try values.decodeIfPresent(Float.self, forKey: .july2023)
        august2023 = try values.decodeIfPresent(Float.self, forKey: .august2023)
        september2023 = try values.decodeIfPresent(Float.self, forKey: .september2023)
        october2023 = try values.decodeIfPresent(Float.self, forKey: .october2023)
        november2023 = try values.decodeIfPresent(Float.self, forKey: .november2023)
        december2023 = try values.decodeIfPresent(Float.self, forKey: .december2023)
    }

}
