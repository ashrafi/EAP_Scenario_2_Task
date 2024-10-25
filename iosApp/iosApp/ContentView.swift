import SwiftUI

struct Fruit: Identifiable {
    let id = UUID()
    let name: String
    let fullName: String
}

struct ContentView: View {
    let fruits = [
        Fruit(name: "Apple", fullName: "Malus domestica"),
        Fruit(name: "Banana", fullName: "Musa acuminata"),
        Fruit(name: "Orange", fullName: "Citrus × sinensis"),
        Fruit(name: "Grapes", fullName: "Vitis vinifera"),
        Fruit(name: "Strawberry", fullName: "Fragaria × ananassa"),
        Fruit(name: "Watermelon", fullName: "Citrullus lanatus"),
        Fruit(name: "Pineapple", fullName: "Ananas comosus"),
        Fruit(name: "Mango", fullName: "Mangifera indica")
    ]

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

                List(fruits) { fruit in
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
