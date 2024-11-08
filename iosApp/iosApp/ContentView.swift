import SwiftUI
import shared

struct ContentView: View {
    @StateObject private var viewModel: FruitViewModel

    // Optional initializer to accept a custom view model for preview purposes
    init(viewModel: FruitViewModel? = nil) {
        _viewModel = StateObject(wrappedValue: viewModel ?? FruitViewModel())
    }

    @State private var cartCount = 0

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
                    Text("Cart has \(cartCount) items")
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
