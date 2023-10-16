//
//  AuthTokenResponse.swift
//  Destiny2-OAuth
//
//  Created by Etienne Martin on 2023-10-16.
//

import Foundation

struct AuthTokenResponse: Codable {
    var accessToken: String
    var tokenType: String
    var expiresIn: Int
    var membershipId: String
}
