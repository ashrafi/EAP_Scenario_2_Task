import SwiftUI
import shared

struct ContentView: View {
    @StateObject private var viewModel: FruitViewModel
    @State private var isExpanded = false  // Track cart expansion

    init(viewModel: FruitViewModel? = nil) {
        _viewModel = StateObject(wrappedValue: viewModel ?? FruitViewModel())
    }

    var body: some View {
        NavigationView {
            VStack {
                // Top row for "Add DB" and "Delete DB" buttons
                HStack {
                    Button(action: {
                        Task {
                            await viewModel.initializeDataIfEmpty()
                        }
                    }) {
                        Text("Add DB")
                            .foregroundColor(.green)
                            .padding(.horizontal)
                    }
                    Spacer()
                    Button(action: {
                        Task {
                            await viewModel.deleteAllFruits()
                        }
                    }) {
                        Text("Delete DB")
                            .foregroundColor(.red)
                            .padding(.horizontal)
                    }
                }
                .padding(.horizontal)

                // Cart and Expand section
                HStack {
                    Text("Cart has \(viewModel.cartCount) items")
                    Spacer()
                    Button(action: {
                        isExpanded.toggle()  // Toggle expand/collapse cart view
                    }) {
                        Text(isExpanded ? "Collapse Cart" : "Expand Cart")
                            .foregroundColor(.blue)
                    }
                }
                .padding()

                // Main list of fruits
                List(viewModel.fruits, id: \.id) { fruit in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(fruit.name)
                                .font(.headline)
                                .foregroundColor(Color(hex: fruit.fruitColor))  // Set name color
                            Text(fruit.fullName)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            
                            // Show additional information if in expanded mode
                            if isExpanded {
                                Text("Calories: \(fruit.calories)")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                                Text("In cart: \(fruit.inCart)")
                                    .font(.footnote)
                                    .foregroundColor(.green)
                            }
                        }
                        Spacer()

                        // Cart quantity controls
                        HStack {
                            Button(action: {
                                Task {
                                    await viewModel.removeFromCart(fruit: fruit)
                                }
                            }) {
                                Image(systemName: "minus.circle")
                                    .foregroundColor(.red)
                            }.buttonStyle(PlainButtonStyle())

                            Text("\(fruit.inCart)")  // Display the current quantity
                                .font(.subheadline)
                                .padding(.horizontal, 8)

                            Button(action: {
                                Task {
                                    await viewModel.addToCart(fruit: fruit)
                                }
                            }) {
                                Image(systemName: "plus.circle")
                                    .foregroundColor(.blue)
                            }.buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding(.vertical, 8)
                }
                .listStyle(PlainListStyle())

                // Expanded Cart Summary
                if isExpanded {
                    ExpandView(viewModel: viewModel)
                }
            }
            .navigationTitle("Fruitties")
        }
    }
}


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)  // Remove # or other invalid characters
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let red, green, blue: Double
        if hex.count == 6 {
            // Parse RGB (24-bit)
            red = Double((int >> 16) & 0xFF) / 255.0
            green = Double((int >> 8) & 0xFF) / 255.0
            blue = Double(int & 0xFF) / 255.0
        } else {
            // Default to white if hex string is invalid
            red = 1.0
            green = 1.0
            blue = 1.0
        }
        
        self.init(red: red, green: green, blue: blue)
    }
}




