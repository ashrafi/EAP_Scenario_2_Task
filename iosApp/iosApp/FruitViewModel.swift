//
//  FruitViewModel.swift
//  iosApp
//
//  Created by Siamak Ashrafi on 11/8/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import shared

@MainActor
class FruitViewModel: ObservableObject {
    @Published private(set) var fruits: [Fruittie] = []  // This is the main data source for the list in the UI
    private let database: AppDatabase
    
    // Computed property to get total items in the cart
    var cartCount: Int32 {
        fruits.reduce(0) { $0 + $1.inCart }
    }

    init() {
        database = Factory().createRoomDatabase()
        Task {
            await initializeDataIfEmpty()
            await activate()
        }
    }

    // Method to conditionally insert initial data into the database if it’s empty
    func initializeDataIfEmpty() async {
        let fruitDao = database.fruittieDao
        
        do {
            let count = try await fruitDao().count()
            
            if count == 0 {
                let initialFruits = [
                    Fruittie(id: 0, name: "Apple", fullName: "Malus domestica", calories: "52", inCart: 0),
                    Fruittie(id: 0, name: "Banana", fullName: "Musa acuminata", calories: "96", inCart: 0),
                    Fruittie(id: 0, name: "Orange", fullName: "Citrus × sinensis", calories: "47", inCart: 0),
                    Fruittie(id: 0, name: "Grapes", fullName: "Vitis vinifera", calories: "69", inCart: 0),
                    Fruittie(id: 0, name: "Strawberry", fullName: "Fragaria × ananassa", calories: "32", inCart: 0),
                    Fruittie(id: 0, name: "Watermelon", fullName: "Citrullus lanatus", calories: "30", inCart: 0)
                ]
                
                try await fruitDao().insert(fruitties: initialFruits)
                print("Inserted initial data")
            } else {
                print("Database already has data, skipping initialization")
            }
        } catch {
            print("Error checking or inserting initial data: \(error)")
        }
    }

    // Method to observe fruits data from the database
    func activate() async {
        let fruitDao = database.fruittieDao
        let flow = fruitDao().getAllAsFlow()

        do {
            for await newFruits in flow {
                self.fruits = newFruits
                print("Number of items in Flow: \(newFruits.count)")
            }
        }
    }

    // Method to add a fruit to the cart or increase its quantity
    func addToCart(fruit: Fruittie) async {
        let fruitDao = database.fruittieDao
        do {
            let newQuantity = fruit.inCart + 1
            try await fruitDao().updateCartQuantity(id: fruit.id, newQuantity: newQuantity)
            print("Updated cart quantity for \(fruit.name) to \(newQuantity)")
        } catch {
            print("Error updating cart quantity: \(error)")
        }
    }

    // Method to remove a fruit from the cart or decrease its quantity
    func removeFromCart(fruit: Fruittie) async {
        let fruitDao = database.fruittieDao
        let newQuantity = max(fruit.inCart - 1, 0)  // Ensure non-negative quantity
        do {
            try await fruitDao().updateCartQuantity(id: fruit.id, newQuantity: newQuantity)
            print("Updated cart quantity for \(fruit.name) to \(newQuantity)")
        } catch {
            print("Error updating cart quantity: \(error)")
        }
    }

    // Method to delete all fruits from the database
    func deleteAllFruits() async {
        let fruitDao = database.fruittieDao
        do {
            try await fruitDao().deleteAll()
            print("All fruits deleted from the database.")
        } catch {
            print("Error deleting all fruits: \(error)")
        }
    }
}
