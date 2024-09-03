//
//  AccountView.swift
//  PyNexus
//
//  Created by patron on 19/02/2024.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        Text("Account")
    }
}

#Preview {
    ZStack {
        LinearGradient(gradient: Gradient(colors: [.deepPurple, .darkPurple]), startPoint: .top, endPoint: .bottom)
            .opacity(0.6)
            .overlay(
                Image("Background")
                    .resizable()
                    .scaledToFill()
                    .opacity(0.7)
            )
            .edgesIgnoringSafeArea(.all)
        AccountView()
        
        VStack {
            CustomBarView(activeTab: .constant(3))
        }
    }
}
