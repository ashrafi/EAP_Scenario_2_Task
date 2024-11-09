//
//  MockFruitViewModel.swift
//  iosApp
//
//  Created by Siamak Ashrafi on 11/8/24.
//  Copyright © 2024 orgName. All rights reserved.
//
import shared

class MockFruitViewModel: FruitViewModel {
    override var fruits: [Fruittie] {
        get {
            [
                
            Fruittie(id: 0, name: "Apple", fullName: "Malus domestica", calories: "52", inCart: 0, fruitColor: "#FF0000", origin: "USA", season: "Fall", description: "Crisp and juicy"),
            Fruittie(id: 0, name: "Banana", fullName: "Musa acuminata", calories: "96", inCart: 0, fruitColor: "#FFD700", origin: "Brazil", season: "Year-round", description: "Rich in potassium"),
            Fruittie(id: 0, name: "Orange", fullName: "Citrus × sinensis", calories: "47", inCart: 0, fruitColor: "#FFA500", origin: "Spain", season: "Winter", description: "Full of Vitamin C"),
            Fruittie(id: 0, name: "Grapes", fullName: "Vitis vinifera", calories: "69", inCart: 0, fruitColor: "#8B008B", origin: "Italy", season: "Fall", description: "Small and sweet"),
            Fruittie(id: 0, name: "Strawberry", fullName: "Fragaria × ananassa", calories: "32", inCart: 0, fruitColor: "#FF6347", origin: "France", season: "Spring", description: "Sweet and aromatic"),
            Fruittie(id: 0, name: "Watermelon", fullName: "Citrullus lanatus", calories: "30", inCart: 0, fruitColor: "#32CD32", origin: "Africa", season: "Summer", description: "Perfect for summer")
        
            ]
        }
        set { }  // Ignore setting, as this is for preview purposes only
    }
}
