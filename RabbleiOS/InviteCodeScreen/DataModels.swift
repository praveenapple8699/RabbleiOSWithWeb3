//
//  DataModels.swift
//  RabbleiOS
//
//  Created by PraveenKumar on 08/10/24.
//

import Foundation

struct InviteCodeValidationDM: Codable {
    var invite_code: String?
    var status, message: String?
    var data: DataDM?
}

struct DataDM: Codable {
    var valid: Bool?
}
