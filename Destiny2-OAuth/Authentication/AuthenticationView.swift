//
//  AuthenticationView.swift
//  Destiny2-OAuth
//
//  Created by Etienne Martin on 2023-10-16.
//

import SwiftUI
import ComposableArchitecture

struct AuthenticationView: View {
    let store: StoreOf<AuthenticationFeature>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 16) {
                if viewStore.isLoading {
                    LoadingView()
                } else if viewStore.isFailed {
                    FailedLoginView(errorMessage: viewStore.errorMessage) {
                        viewStore.send(.signIn)
                    }
                } else if viewStore.isAuthenticated {
                    LoggedInView(accountName: viewStore.userName) {
                        viewStore.send(.logout)
                    }
                } else {
                    SignInView {
                        viewStore.send(.signIn)
                    }
                }
            }
        }
    }
}

#Preview {
    AuthenticationView(store: Store(initialState: AuthenticationFeature.State(
        isAuthenticated: false,
        isFailed: false)) {
        AuthenticationFeature()
    })
}
