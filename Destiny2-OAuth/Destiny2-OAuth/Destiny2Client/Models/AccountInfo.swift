//
//  AccountInfo.swift
//  Destiny2-OAuth
//
//  Created by Etienne Martin on 2023-10-16.
//

import Foundation

struct AccountInfo: Codable {
    let membershipId: String
    let uniqueName: String
    let displayName: String
    let profilePicture: Int
    let profilePicturePath: String
    let userTitleDisplay: String
}
