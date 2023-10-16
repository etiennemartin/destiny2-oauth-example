//
//  Destiny2URLBuilder.swift
//  Destiny2-OAuth
//
//  Created by Etienne Martin on 2023-10-16.
//

import Foundation

struct Destiny2URLBuilder {
    private let clientId = Destiny2AppValues.clientId
    
    // Generates a URL used to generate a permissions code used to generate API tokens.
    // https://www.bungie.net/en/OAuth/Authorize?client_id={client_id}&response_type=code
    func authUrl() -> URL {
        return URL(string: "https://www.bungie.net/en/OAuth/Authorize?client_id=\(clientId)&response_type=code")!
    }

    // Creates a URLRequest used to generate auth tokens
    func tokenUrlRequest(code: String) -> URLRequest {
        var request = URLRequest(url: URL(string: "https://www.bungie.net/Platform/App/OAuth/token/")!)
        request.httpBody = "client_id=\(clientId)&grant_type=authorization_code&code=\(code)".data(using: .utf8)!
        request.httpMethod = "POST"
        return request
    }
}
