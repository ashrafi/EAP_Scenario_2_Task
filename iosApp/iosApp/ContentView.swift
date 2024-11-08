import SwiftUI
import shared


import SwiftUI

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
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Cart Summary")
                            .font(.headline)
                            .padding(.top)

                        ForEach(viewModel.fruits.filter { $0.inCart > 0 }, id: \.id) { fruit in
                            HStack {
                                Text(fruit.name)
                                Spacer()
                                Text("Quantity: \(fruit.inCart)")
                            }
                            .font(.subheadline)
                        }

                        Text("Total items in cart: \(viewModel.cartCount)")
                            .font(.footnote)
                            .padding(.top, 8)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                }
            }
            .navigationTitle("Fruitties")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: MockFruitViewModel())
    }
}
