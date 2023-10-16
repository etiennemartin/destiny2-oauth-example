//
//  LoggedInView.swift
//  Destiny2-OAuth
//
//  Created by Etienne Martin on 2023-10-16.
//

import SwiftUI

struct LoggedInView: View {
    var accountName: String
    var logout: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.blue)
            Text("Welcome \(accountName), you are now authenticated")
                .foregroundColor(.secondary)
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding()
            Button {
                logout()
            } label: {
                Text("Logout")
                    .foregroundColor(.white)
                    .padding()
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
    }
}

#Preview {
    LoggedInView(accountName: "Guardian") {
        print("Logout pressed!")
    }
}
