//
//  SignInView.swift
//  Destiny2-OAuth
//
//  Created by Etienne Martin on 2023-10-16.
//

import SwiftUI

struct SignInView: View {
    var login: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.green)
            Text("Signing into your Destiny 2 account is required.")
                .foregroundColor(.secondary)
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding()
            Button {
                login()
            } label: {
                Text("Sign In")
                    .foregroundColor(.white)
                    .padding()
                    .background(.green)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
    }
}

#Preview {
    SignInView {
        print("Sign in pressed")
    }
}
