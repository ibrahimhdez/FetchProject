//
//  FetchViewModel.swift
//  FetchProject
//
//  Created by Ibrahim Hernández Jorge on 8/11/23.
//

import Foundation

@MainActor final class FetchViewModel: ObservableObject {
    @Published var meals = [Meal]()
    @Published var mealDetails: MealDetails?
    private let urlMealsAPI = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
    private let urlMealDetailAPI = "https://themealdb.com/api/json/v1/1/lookup.php?i="

    func fetchMeals() async {
        fetchData(Meals.self, urlString: urlMealsAPI) { response in
            switch response {
            case .success(let meals):
                guard let meals = meals.meals else { return }
                DispatchQueue.main.async {
                    //Sorting array by meal name
                    self.meals = meals.sorted { ($0.strMeal ?? "") < ($1.strMeal ?? "") }
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    func fetchMealDetails(for id: String?) async {
        guard let id else { return }
        fetchData(MealsDetails.self, urlString: getFinalMealDetailURLString(for: id)) { response in
            switch response {
            case .success(let mealsDetails):
                DispatchQueue.main.async {
                    if let mealDetails = mealsDetails.meals {
                        self.mealDetails = mealDetails.first
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

private extension FetchViewModel {
    func fetchData<T: Codable>(_: T.Type, urlString: String, completion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data else { return }
            do {
                let products = try JSONDecoder().decode(T.self, from: data)
                completion(.success(products))
            }
            catch {
                completion(.failure(error))
            }
        }.resume()
    }

    func getFinalMealDetailURLString(for id: String) -> String {
        return urlMealDetailAPI + id
    }
}
