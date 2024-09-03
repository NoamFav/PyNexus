import SwiftUI

struct IntroView: View {
    var body: some View {
            VStack {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .center, spacing: 20) {
                        Spacer(minLength: 50)
                        
                        Image("PythonLogo.svg")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .shadow(radius: 5)
                            .padding(.bottom, 20)
                        
                        Text("Welcome to PyNexus")
                            .font(.system(size: 35, weight: .bold, design: .serif))
                            .foregroundColor(.veryLightPurple)
                            .shadow(radius: 1)
                        
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Overview")
                                .font(.title2.bold())
                                .foregroundColor(.lightPurple)
                            
                            Text("Dive into Python with PyNexus, covering basics to advanced concepts including object-oriented programming, with key libraries like matplotlib, numpy, and scipy. Ideal for all learners.")
                                .foregroundColor(.veryLightPurple)
                                .lineSpacing(5)
                        }
                        .padding()
                        .background(Color.black.opacity(0.5))
                        .cornerRadius(15)
                        .shadow(radius: 5)
                        .padding(.horizontal)
                        
                        Text("")
                    }
                    .padding(.bottom, 80)
                }
                
                Spacer()
            }
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
        IntroView()
        
        VStack {
            CustomBarView(activeTab: .constant(0))
        }
    }
}
