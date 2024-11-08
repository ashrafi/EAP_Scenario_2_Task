import SwiftUI
import shared


struct ContentView: View {
    @StateObject private var viewModel: FruitViewModel

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
                    Text("Cart has \(viewModel.cartCount) items")  // Display cartCount from viewModel
                    Spacer()
                    Button(action: {
                        // Add expand functionality here
                    }) {
                        Text("expand")
                            .foregroundColor(.blue)
                    }
                }
                .padding()

                // List of fruits
                List(viewModel.fruits, id: \.id) { fruit in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(fruit.name)
                                .font(.headline)
                            Text(fruit.fullName)
                                .font(.subheadline)
                                .foregroundColor(.gray)
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
