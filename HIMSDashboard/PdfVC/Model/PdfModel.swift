//
//  PdfModel.swift
//  HIMSDashboard
//
//  Created by Kondal Naidu on 14/11/23.
//

import Foundation
struct PdfModel : Codable {
    let url : String?
    let status : String?

    enum CodingKeys: String, CodingKey {

        case url = "url"
        case status = "Status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}
