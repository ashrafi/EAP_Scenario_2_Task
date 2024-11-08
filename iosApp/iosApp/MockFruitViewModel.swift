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
                Fruittie(id: 0, name: "Apple", fullName: "Malus domestica", calories: "52"),
                Fruittie(id: 0, name: "Banana", fullName: "Musa acuminata", calories: "96"),
                Fruittie(id: 0, name: "Orange", fullName: "Citrus × sinensis", calories: "47"),
                Fruittie(id: 0, name: "Grapes", fullName: "Vitis vinifera", calories: "69"),
                Fruittie(id: 0, name: "Strawberry", fullName: "Fragaria × ananassa", calories: "32"),
                Fruittie(id: 0, name: "Watermelon", fullName: "Citrullus lanatus", calories: "30")
            ]
        }
        set { }  // Ignore setting, as this is for preview purposes only
    }
}