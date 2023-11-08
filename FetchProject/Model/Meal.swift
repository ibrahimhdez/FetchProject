//
//  Meal.swift
//  FetchProject
//
//  Created by Ibrahim Hernández Jorge on 8/11/23.
//

struct Meals: Codable {
    var meals: [Meal]?
}

struct Meal: Codable, Hashable {
    var strMeal: String?
    var strMealThumb: String?
    var idMeal: String?
}
