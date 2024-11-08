/*
 * Copyright 2024 The Android Open Source Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package com.example.fruitties.model

import androidx.room.Entity
import androidx.room.PrimaryKey
import kotlinx.serialization.SerialName
import kotlinx.serialization.Serializable

@Serializable
@Entity
data class Fruittie(
    @PrimaryKey(autoGenerate = true) val id: Long = 0,
    @SerialName("name")
    val name: String,
    @SerialName("full_name")
    val fullName: String,
    @SerialName("calories")
    val calories: String,
    @SerialName("in_cart")
    val inCart: Int = 0,  // Track the quantity in the cart

    // New fields
    @SerialName("fruit_color")
    val fruitColor: String,  // e.g., "Red", "Yellow"

    @SerialName("origin")
    val origin: String,  // e.g., "USA", "Brazil"

    @SerialName("season")
    val season: String,  // e.g., "Summer", "Year-round"

    @SerialName("description")
    val description: String  // Additional details about the fruit
)
