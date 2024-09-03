import SwiftUI

struct ContentView: View {
    @State private var activeTab: Int = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.deepPurple, .darkPurple]), startPoint: .top, endPoint: .bottom)
                .opacity(0.7)
                .overlay(
                    Image("Background")
                        .resizable()
                        .scaledToFill()
                        .opacity(0.7)
                )
                .edgesIgnoringSafeArea(.all)
            
            TabView(selection: $activeTab) {
                IntroView()
                    .tag(0)
                    .onAppear{
                        self.hideKeyboard()
                    }
                CoursesView()
                    .tag(1)
                    .onAppear{
                        self.hideKeyboard()
                    }
                ConsoleView()
                    .tag(2)
                    .onAppear{
                        self.hideKeyboard()
                    }
                AccountView()
                    .tag(3)
                    .onAppear{
                        self.hideKeyboard()
                    }
                
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .animation(.easeInOut, value: activeTab)
        }
        .overlay {
            VStack {
                CustomBarView(activeTab: $activeTab)
                    .frame(maxWidth: .infinity)
                .shadow(radius: 10)
            }
            .ignoresSafeArea(.keyboard)
        }
    }
}

#Preview {
    ContentView()
}
