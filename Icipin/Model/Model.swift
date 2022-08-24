//
//  Model.swift
//  Icipin
//
//  Created by Rivaldo Fernandes on 24/08/22.
//

import SwiftUI

// MARK: - User
struct UserModel: Codable {
    let name: String
    let quest: [QuestModel]
}

// MARK: - Quest
struct QuestModel: Codable {
    let category, foodName, hexcolor, icon, labelml: String
    let status: Int
    let story, title: String
    let clue: [ClueModel]
    let places: [PlaceModel]

    enum CodingKeys: String, CodingKey {
        case category
        case foodName = "food_name"
        case hexcolor, icon, status, story, title, clue, places, labelml
    }
}

// MARK: - Clue
struct ClueModel: Codable {
    let title: String
}

// MARK: - Place
struct PlaceModel: Codable {
    let name: String
    let latitude, longitude, rating: Double
}

