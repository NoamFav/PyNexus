//
//  ConsoleView.swift
//  PyNexus
//
//  Created by patron on 19/02/2024.
//

import SwiftUI
import CodeEditor

struct ConsoleView: View {
    @State private var ToRun = false
    @State private var codeText: String = "print('Hello, world!')"
    @State private var theme = CodeEditor.ThemeName.pojoaque
    @State public var codeOutput: String = "placeholder"
    
    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Spacer()
                    Picker("Theme", selection: $theme) {
                        ForEach(CodeEditor.availableThemes, id: \.self) { theme in
                            Text(theme.rawValue.capitalized)
                                .foregroundColor(.veryLightPurple)
                                .tag(theme)
                        }
                    }
                    .pickerStyle(.automatic)
                    .foregroundColor(.veryLightPurple)
                    .background(Color.deepPurple)
                    .cornerRadius(10)
                    .padding()
                    .shadow(radius: 5)
                    
                    Button(action: {
                        self.codeOutput = "Executing..."
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            sendScriptToServer(script: codeText) { result in
                                self.codeOutput = result
                            }
                        }
                    }) {
                        Image(systemName: "play.fill")
                            .foregroundColor(.veryLightPurple)
                            .scaleEffect(2)
                    }
                    .buttonStyle(PlainButtonStyle())
                    .frame(width: 60, height: 60)
                    .background(Color.lightPurple.opacity(0.6))
                    .cornerRadius(30)
                    .shadow(radius: 5)
                    
                    Spacer()
                }
                
                CodeEditor(source: $codeText, language: .python, theme: theme, flags: [ .selectable, .editable, .smartIndent ], indentStyle: .softTab(width: 2))
                    .frame(height: 400)
                    .cornerRadius(10)
                    .padding()
                
                
                Text(codeOutput)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                    .background(Color.darkPurple)
                    .foregroundColor(.veryLightPurple)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(LinearGradient(gradient: Gradient(colors: [.moderatePurple, .lightPurple]), startPoint: .topLeading, endPoint: .bottomTrailing), lineWidth: 2)
                    )
                    .padding([.leading, .bottom, .trailing])
                
            }
            .background(Color.customBlack)
            .cornerRadius(15)
            .shadow(radius: 5)
            .padding()
        }
        .padding(.bottom, 10)
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
        ConsoleView()
        
        VStack {
            CustomBarView(activeTab: .constant(2))
        }
    }
}
