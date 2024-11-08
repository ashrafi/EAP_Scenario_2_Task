//
//  FruitViewModel.swift
//  iosApp
//
//  Created by Siamak Ashrafi on 11/8/24.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import shared

import SwiftUI
import shared

@MainActor
class FruitViewModel: ObservableObject {
    @Published private(set) var fruits: [Fruittie] = []
    private let database: AppDatabase

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
            // Correct syntax to check if the database is empty
            let count = try await fruitDao().count()
            
            if count == 0 {
                // Example data to insert into the database
                let initialFruits = [
                    Fruittie(id: 0, name: "Apple", fullName: "Malus domestica", calories: "52"),
                    Fruittie(id: 0, name: "Banana", fullName: "Musa acuminata", calories: "96"),
                    Fruittie(id: 0, name: "Orange", fullName: "Citrus × sinensis", calories: "47"),
                    Fruittie(id: 0, name: "Grapes", fullName: "Vitis vinifera", calories: "69"),
                    Fruittie(id: 0, name: "Strawberry", fullName: "Fragaria × ananassa", calories: "32"),
                    Fruittie(id: 0, name: "Watermelon", fullName: "Citrullus lanatus", calories: "30")
                ]
                
                // Insert the initial data into the database
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
}
