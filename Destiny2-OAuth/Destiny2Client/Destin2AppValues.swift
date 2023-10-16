//
//  Destin2AppValues.swift
//  Destiny2-OAuth
//
//  Created by Etienne Martin on 2023-10-16.
//

import Foundation

// These values are required for authentication with the Destiny 2 API. You can register
// your app at the following link:
//
// https://www.bungie.net/en/Application
//
// Application Status: Public
// OAuth Client type: Public
enum Destiny2AppValues {
    // Under the section "API KEYS" once registerd, fill in the following values:
    
    // API Key
    static let apiKey = "<INSERT_API_KEY_HERE>"
    
    // OAuth client_id
    static let clientId = 123456
    
    // Redirect URL (Under App Authentication). Do not add :// to the value below, this will
    // crash the app.
    //
    // example: Bungie Admin: "MyDestinyAppScheme://" -> Below: "MyDestinyAppScheme"
    static let scheme = "MyDestinyAppScheme"
}
