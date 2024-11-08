import SwiftUI
import shared

struct Fruit: Identifiable {
    let id = UUID()
    let name: String
    let fullName: String
}

struct ContentView: View {
    @StateObject private var viewModel = FruitViewModel()


    @State private var cartCount = 0

    var body: some View {
        NavigationView {
            VStack {
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
        ContentView()
    }
}
