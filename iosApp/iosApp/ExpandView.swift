//
//  ExpandView.swift
//  iosApp
//
//  Created by Siamak Ashrafi on 11/8/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct ExpandView: View {
    @ObservedObject var viewModel: FruitViewModel  // Pass the viewModel to access cart data

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Cart Summary")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top)
                .padding(.horizontal)

            ScrollView {  // Add scroll view for longer cart summary
                VStack(alignment: .leading, spacing: 12) {
                    ForEach(viewModel.fruits.filter { $0.inCart > 0 }, id: \.id) { fruit in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text(fruit.name)
                                    .font(.headline)
                                    .foregroundColor(Color(hex: fruit.fruitColor))
                                Spacer()
                                Text("Qty: \(fruit.inCart)")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                            }

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Origin: \(fruit.origin)")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                                Text("Season: \(fruit.season)")
                                    .font(.footnote)
                                    .foregroundColor(.secondary)
                                /*Text(fruit.description)
                                    .font(.footnote)
                                    .italic()
                                    .foregroundColor(.secondary)*/
                            }
                            .padding(.leading)
                        }
                        .padding()
                        .background(Color(.systemGray5))
                        .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
            }

            // Total items in cart at the bottom
            Text("Total items in cart: \(viewModel.cartCount)")
                .font(.subheadline)
                .fontWeight(.bold)
                .padding(.top, 8)
                .padding(.horizontal)
        }
        .padding(.bottom)  // Extra padding at the bottom for spacing
        .background(Color(.systemGray6))
        .cornerRadius(12)
        .padding(.horizontal)
    }
}
