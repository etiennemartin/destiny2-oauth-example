//
//  FailedLoginView.swift
//  Destiny2-OAuth
//
//  Created by Etienne Martin on 2023-10-16.
//

import SwiftUI

import SwiftUI

struct FailedLoginView: View {
    var errorMessage: String
    var retry: () -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "person.crop.circle.badge.exclamationmark")
                .resizable()
                .frame(width: 115, height: 100)
                .foregroundColor(.red)
            Text("Failed to login to your Destiny 2 Profile.")
                .foregroundColor(.secondary)
                .font(.title3)
                .multilineTextAlignment(.center)
                .padding()
            Text(errorMessage)
                .foregroundColor(.secondary)
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding()
            Button {
                retry()
            } label: {
                Text("Retry")
                    .foregroundColor(.white)
                    .padding()
                    .background(.red)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
    }
}

#Preview {
    FailedLoginView(errorMessage: "Sample Error Mesage") {
        print("Retry button was pressed")
    }
}
