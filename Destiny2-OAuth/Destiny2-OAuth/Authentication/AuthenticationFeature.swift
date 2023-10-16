//
//  AuthenticationFeature.swift
//  Destiny2-OAuth
//
//  Created by Etienne Martin on 2023-10-16.
//

import Foundation
import AuthenticationServices
import ComposableArchitecture
import SwiftUI

struct AuthenticationFeature: Reducer {
    @Dependency(\.destiny2Client) var client
    
    struct State: Equatable {
        var isAuthenticated = false
        var isFailed = false
        var errorMessage = "Failed to get Profile"
        var isLoading = false
        var userName = ""
    }
    
    enum Action {
        case signIn
        case signInResponse(Bool)
        case retry
        case logout
        case fetchAccountInfo
        case fetchAccountResponse(AccountInfo)
    }
    
    func reduce(into state: inout State, action: Action) -> Effect<Action> {
        switch action {
        case .signIn, .retry:
            return .run { send in
                do {
                    try await send(.signInResponse(client.signIn()))
                } catch {
                    // Swallow error for the time being
                }
            }
            
        case .signInResponse(let isLoggedIn):
            if isLoggedIn {
                state.isAuthenticated = true
                state.isFailed = false
                return .send(.fetchAccountInfo)
            } else {
                return .send(.retry)
            }
            
        case .fetchAccountInfo:
            state.isLoading = true
            return .run { send in
                do {
                    try await send(.fetchAccountResponse(client.fetchAccountInfo()))
                } catch {
                    // Swallow error for the time being.
                }
            }
            
        case .fetchAccountResponse(let accountInfo):
            state.userName = accountInfo.displayName
            state.isAuthenticated = true
            state.isFailed = false
            state.isLoading = false
            return .none
            
        case .logout:
            state.isAuthenticated = false
            state.isFailed = false
            return .none
        }
    }
}
