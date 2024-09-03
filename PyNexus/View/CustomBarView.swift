//
//  CustomBarView.swift
//  PyNexus
//
//  Created by patron on 16/02/2024.
//

import SwiftUI

struct CustomBarView: View {
    // Example active state for demonstration
    @Binding var activeTab: Int
    
    var body: some View {
        Spacer()
        HStack {
            Spacer()
            Button(action: { self.activeTab = 0 }) {
                VStack {
                    Image(systemName: "house.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(activeTab == 0 ? .veryLightPurple : .moderatePurple)
                    Text("Home")
                        .font(.caption)
                        .foregroundColor(.veryLightPurple)
                }
            }
            Spacer()
            Button(action: { self.activeTab = 1 }) {
                VStack {
                    Image(systemName: "list.clipboard.fill")
                        .resizable()
                        .frame(width: 40, height: 50)
                        .foregroundColor(activeTab == 1 ? .veryLightPurple : .moderatePurple)
                    Text("Courses")
                        .font(.caption)
                        .foregroundColor(.veryLightPurple)
                }
            }
            Spacer()
            Button(action: { self.activeTab = 2 }) {
                VStack {
                    Image(systemName: "apple.terminal.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundColor(activeTab == 2 ? .veryLightPurple : .moderatePurple)
                    Text("Console")
                        .font(.caption)
                        .foregroundColor(.veryLightPurple)
                }
            }
            Spacer()
            Button(action: { self.activeTab = 3 }) {
                VStack {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(activeTab == 3 ? .veryLightPurple : .moderatePurple)
                    Text("Profile")
                        .font(.caption)
                        .foregroundColor(.veryLightPurple)
                }
            }
            Spacer()
        }
        .frame(height: 80)
        .padding(.horizontal)
        .background(LinearGradient(gradient: Gradient(colors: [.deepPurple, .darkPurple]), startPoint: .leading, endPoint: .trailing))
        .cornerRadius(20)
        .shadow(radius: 10)
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
        CustomBarView(activeTab: .constant(1))
    }
}
