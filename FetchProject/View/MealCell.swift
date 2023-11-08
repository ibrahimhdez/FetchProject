//
//  MealCell.swift
//  FetchProject
//
//  Created by Ibrahim Hernández Jorge on 8/11/23.
//

import SwiftUI

struct MealCell: View {
    private let meal: Meal
    private let cellHeight: CGFloat = 150

    init(meal: Meal) {
        self.meal = meal
    }

    var body: some View {
        ZStack {
            ZStack {
                Text(meal.strMeal ?? "")
                    .foregroundColor(.white)
                    .font(.system(size: 20, weight: .bold))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }
            .background(Color.darkGray.opacity(0.6))
            .cornerRadius(8)
            .padding(.horizontal)
        }
        .frame(maxWidth: .infinity)
        .frame(height: cellHeight)
        .background {
            AsyncImage(
                url: getImageURL(),
                transaction: Transaction(animation: .easeIn(duration: 1))) { phase in
                    switch phase {
                    case .success(let image):
                        image.resizable()
                            .scaledToFill()
                            .task {
                                //Storing image after downloading, so we dont have to download the same image twice or more
                                MealImageHelper.shared.storeImage(for: meal.idMeal, with: image)
                            }
                    default:
                        Color.darkGray.opacity(0.1)
                    }
                }
        }
        .cornerRadius(8)
        .shadow(color: Color.darkGray, radius: 5, x: 2, y: 2)
    }
}

private extension MealCell {
    func getImageURL() -> URL? {
        guard let imageURLString = meal.strMealThumb else { return nil }
        return URL(string: imageURLString)
    }
}
