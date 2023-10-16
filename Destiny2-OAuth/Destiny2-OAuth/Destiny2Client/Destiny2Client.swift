//
//  Destiny2Client.swift
//  Destiny2-OAuth
//
//  Created by Etienne Martin on 2023-10-16.
//

import Foundation
import AuthenticationServices
import ComposableArchitecture

enum Destiny2ApiError: Error {
    case decodeFailure(String)
    case responseError(Int, String) // ErrorCode, ErrorMessage
    case invalidStatusCode(Int) // statusCode
    case invalidServerResponse
}

protocol Destiny2Client: DependencyKey {
    func signIn() async throws -> Bool
    func logout()
    func fetchAccountInfo() async throws -> AccountInfo
}

protocol Destiny2ClientAuthenticationDelegate {
    func clientDidLoggout()
    func clientDidGetUnauthenticated()
}

class Destiny2ClientImpl: NSObject, Destiny2Client {
    static var liveValue: Destiny2ClientImpl {
        return Destiny2ClientImpl()
    }
    
    var delegate: Destiny2ClientAuthenticationDelegate?
    
    private var authSession: ASWebAuthenticationSession?
    private var session: URLSession
    private let urlBuilder = Destiny2URLBuilder()
    
    private let apiKey = Destiny2AppValues.apiKey
    private var expectedScheme = Destiny2AppValues.scheme
    
    private var code: String? = nil
    private var authResponse: AuthTokenResponse? = nil
    
    override init() {
        let config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    // Wrapper around callback method to support async/await
    func signIn() async throws -> Bool {
        return try await withCheckedThrowingContinuation { continuation in
            signIn { result in
                switch result {
                case .success(let isLoggedIn):
                    continuation.resume(returning: isLoggedIn)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    // Opens a full screen web view that will prompt the user to authenticate with the API. This is an ephemeral
    // web view. This should only be called if the auth token is nil or invalid (expired)
    private func signIn(completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = urlBuilder.authUrl()
        authSession = ASWebAuthenticationSession(url: url, callbackURLScheme: expectedScheme) { [weak self] url, error in
            if let url = url {
                if let components = URLComponents(string: url.absoluteString) {
                    let codeItem = components.queryItems?.first { $0.name == "code" }
                    
                    if let error = error {
                        completion(.failure(error))
                        return
                    }
                    
                    if let code = codeItem?.value {
                        self?.code = code
                        self?.fetchAuthToken(completion: completion)
                    }
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }
        authSession?.prefersEphemeralWebBrowserSession = true
        authSession?.presentationContextProvider = self
        
        // Since start() requires being called on the UI Thread, we need to dispatch back
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {
                return
            }
            authSession?.start()
        }
    }
    
    // Fetch an authentication token based on the code generated by the original authentication code.
    // If the code is nil this method does nothing, call signIn() first.
    private func fetchAuthToken(completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let code = code else {
            print("Attempting to fetch auth token without a code.")
            return
        }
        
        session.dataTask(with: urlBuilder.tokenUrlRequest(code: code)) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    self?.authResponse = try decoder.decode(AuthTokenResponse.self, from: data)
                    self?.updateSessionWithHeaders()
                    completion(.success(true))
                } catch (let error) {
                    completion(.failure(Destiny2ApiError.decodeFailure("\(error)")))
                }
            }
        }.resume()
    }
    
    private func updateSessionWithHeaders() {
        guard let auth = authResponse else {
            print("Attepting to assign auth tokens with no authentication.")
            return
        }
        
        // Can't mutate session configration, so we create a new one.
        let config = session.configuration
        config.httpAdditionalHeaders = [
            "X-API-Key": apiKey,
            "Authorization": "Bearer \(auth.accessToken)"
        ]
        session = URLSession(configuration: config)
    }
    
    func logout() {
        code = nil
        authResponse = nil
        
        delegate?.clientDidLoggout()
    }
    
    func fetchAccountInfo() async throws -> AccountInfo {
        let url = URL(string: "https://www.bungie.net/Platform/User/GetCurrentBungieNetUser/")!
        let (data, urlResponse) = try await session.data(from: url)
        
        guard let response = urlResponse as? HTTPURLResponse else {
            throw Destiny2ApiError.invalidServerResponse
        }
        guard response.statusCode > 199 && response.statusCode <= 299 else {
            throw Destiny2ApiError.invalidStatusCode(response.statusCode)
        }
        
        do {
            let response = try JSONDecoder().decode(APIObject<AccountInfo>.self, from: data)
            if response.ErrorCode != 1 {
                print("Failed API call, errCode:\(response.ErrorCode), errorStatus:\(response.ErrorStatus)")
                throw Destiny2ApiError.responseError(response.ErrorCode, response.ErrorStatus)
            }
            return response.Response
        } catch (let error) {
            throw Destiny2ApiError.decodeFailure("\(error)")
        }
    }
}

extension Destiny2ClientImpl: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return ASPresentationAnchor()
    }
}

// Allows for @Dependency(\.destiny2Client) to be used.
extension DependencyValues {
    var destiny2Client: Destiny2ClientImpl {
        get { self[Destiny2ClientImpl.self] }
        set { self[Destiny2ClientImpl.self] = newValue }
    }
}
