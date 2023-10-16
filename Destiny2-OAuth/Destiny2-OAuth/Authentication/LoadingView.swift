//
//  LoadingView.swift
//  Destiny2-OAuth
//
//  Created by Etienne Martin on 2023-10-16.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
                .padding()
            Text("Loading...")
        }
    }
}

#Preview {
    LoadingView()
}
