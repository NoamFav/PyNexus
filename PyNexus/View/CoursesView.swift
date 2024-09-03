import SwiftUI

struct CoursesView: View {
    @State private var showSublist: [String: Bool] = [:]
    @State private var unlockedItems: [String: Int] = [:]

    var info: [String]

    let subInfo: [String: [String]]
    
    
    init() {
        info = [
            "Fundamentals",
            "Data Structures",
            "Object-Oriented Programming",
            "Advanced Topics",
            "Libraries and Frameworks",
            "Practical Applications",
            "Testing and Best Practices"
        ]
        
        subInfo = [
                "Fundamentals": ["Syntax and Semantics", "Variables and Data Types", "Operators", "Conditional Statements (if, elif, else)", "Loops (for, while)", "Functions and Recursion", "Basic I/O", "Exception Handling"],
                "Data Structures": ["Lists and List Comprehension", "Dictionaries", "Tuples", "Sets", "Strings and String Manipulation", "Stacks and Queues"],
                "Object-Oriented Programming": ["Classes and Objects", "Inheritance", "Polymorphism", "Encapsulation", "Abstract Classes and Interfaces"],
                "Advanced Topics": ["Decorators", "Generators and Iterators", "Lambda Functions", "Modules and Packages", "File Handling", "Context Managers"],
                "Libraries and Frameworks": ["NumPy for Numerical Computing", "Pandas for Data Analysis", "Matplotlib and Seaborn for Data Visualization", "SciPy for Scientific Computing", "Scikit Learn for Machine Learning", "Tkinter for Graphic User Interface"],
                "Practical Applications": ["Web Scraping with Beautiful Soup", "Automating Tasks with Python", "Data Analysis Projects", "Deep Learning with TensorFlow or PyTorch", "Building APIs with Flask or Django"],
                "Testing and Best Practices": ["Writing Unit Tests", "Debugging in Python", "Virtual Environments", "Code Profiling and Optimization", "Writing Clean and Readable Code", "Version Control with Git"]
            ]
        _unlockedItems = State(initialValue: subInfo.reduce(into: [:]) { $0[$1.key] = 0 })
    }
    
    var body: some View {
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(info, id: \.self) { category in
                        if let items = subInfo[category] {
                            let binding = Binding<Bool>(
                                get: { self.showSublist[category, default: false] },
                                set: { self.showSublist[category] = $0 }
                            )
                            CategoryView(category: category, items: items, showSublist: binding, unlockedIndex: $unlockedItems[category])
                        }
                    }
                }
                .padding()
            }
        }
    }

struct CategoryView: View {
    var category: String
    var items: [String]
    @Binding var showSublist: Bool
    @Binding var unlockedIndex: Int?

    var body: some View {
        VStack {
            HStack {
                Text(category)
                    .fontWeight(.semibold)
                    .foregroundColor(.veryLightPurple)
                    .padding(.vertical, 10)
                    .padding(.leading, 20)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.veryLightPurple)
                    .rotationEffect(.degrees(showSublist ? 90 : 0))
                    .padding(.trailing, 20)
            }
            .background(LinearGradient(gradient: Gradient(colors: [.moderatePurple, .darkPurple]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(10)
            .onTapGesture {
                withAnimation(.spring()) {
                    showSublist.toggle()
                }
            }
            
            // Sublist Items
            if showSublist {
                VStack(spacing: 0) {
                    ForEach(items.indices, id: \.self) { index in
                        HStack {
                            Text(items[index])
                                .foregroundColor(index <= (unlockedIndex ?? -1) ? .veryLightPurple : .gray)
                                .padding(.vertical, 10)
                                .padding(.leading, 20)
                            
                            Spacer()
                            
                            Image(systemName: index <= (unlockedIndex ?? -1) ? "checkmark.circle.fill" : "lock.fill")
                                .foregroundColor(index <= (unlockedIndex ?? -1) ? .green : .red)
                                .padding(.trailing, 20)
                        }
                        .background(index % 2 == 0 ? Color.deepPurple.opacity(0.2) : Color.darkPurple.opacity(0.2))
                        .cornerRadius(10)
                        .onTapGesture {
                            if index == unlockedIndex {
                                unlockedIndex? += 1
                            }
                        }
                    }
                }
                .padding(.top, 5)
                .transition(.opacity)
                
            }
        }
        .padding(.bottom, 5)
        .background(Color.customBlack.opacity(0.1))
        .cornerRadius(12)
        .shadow(radius: 2)
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
        CoursesView()
        
        VStack {
            CustomBarView(activeTab: .constant(1))
        }
    }
}
