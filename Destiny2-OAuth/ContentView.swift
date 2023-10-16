//
//  ContentView.swift
//  Destiny2-OAuth
//
//  Created by Etienne Martin on 2023-10-16.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    var body: some View {
        AuthenticationView(store: Store(initialState: AuthenticationFeature.State()) {
            AuthenticationFeature()
        })
    }
}

#Preview {
    ContentView()
}
