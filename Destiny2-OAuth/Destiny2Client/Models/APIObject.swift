//
//  APIObject.swift
//  Destiny2-OAuth
//
//  Created by Etienne Martin on 2023-10-16.
//

import Foundation

// The Destiny API uses capitals for these top level properties
struct APIObject<T: Codable>: Codable {
    var Response: T
    var ErrorCode: Int
    var ThrottleSeconds: Int
    var ErrorStatus: String
    var Message: String
//    var MessageData: Type?
}
