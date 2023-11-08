//
//  MealDetailslView.swift
//  FetchProject
//
//  Created by Ibrahim Hernández Jorge on 8/11/23.
//

import SwiftUI

struct MealDetailslView: View {
    @StateObject private var viewModel = FetchViewModel()
    private let meal: Meal

    init(meal: Meal) {
        self.meal = meal
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                header
                HStack {
                    ingredientsStack
                    Spacer()
                    instructionsStack
                }
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchMealDetails(for: meal.idMeal)
            }
        }
    }

    private var header: some View {
        ZStack {
            Text(meal.strMeal ?? "")
                .foregroundStyle(.white)
                .font(.system(size: 35, weight: .bold))
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .background(Color.darkGray.opacity(0.6))
        .cornerRadius(8)
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .frame(height: 150)
        .background(MealImageHelper.shared.getImage(for: meal.idMeal).opacity(0.6))
    }

    private var ingredientsStack: some View {
        ZStack {
            VStack {
                HStack {
                    MealDetailsSubTitle(title: "Ingredients")
                    Spacer()
                }
                Spacer()
                    .frame(height: 10)
                ForEach(viewModel.mealDetails?.getIngredients() ?? [], id: \.self) { ingredient in
                    HStack {
                        MealDetailsText(text: "· \(ingredient)")
                        Spacer()
                    }
                }
                Spacer()
            }
        }
        .padding(.all)
        .background(Color.paleYellow)
        .cornerRadius(8)

    }

    private var instructionsStack: some View {
        ZStack {
            VStack {
                HStack {
                    MealDetailsSubTitle(title: "Instructions", color: .white)
                    Spacer()
                }
                Spacer()
                    .frame(height: 10)
                MealDetailsText(text: viewModel.mealDetails?.strInstructions ?? "", color: .white)
                Spacer()
            }
            .padding(.all)
        }
        .background(Color.darkGray.opacity(0.6))
        .cornerRadius(8)
        .padding(.leading)
    }
}

struct MealDetailsSubTitle: View {
    private let title: String
    private let color: Color

    init(title: String, color: Color = .black) {
        self.title = title
        self.color = color
    }

    var body: some View {
        Text(title)
            .foregroundColor(color)
            .font(.system(size: 20, weight: .bold))
            .scaledToFill()
            .minimumScaleFactor(0.5)
            .lineLimit(1)
            .multilineTextAlignment(.leading)
            .padding(.horizontal)
    }
}

struct MealDetailsText: View {
    private let text: String
    private let color: Color

    init(text: String, color: Color = .black) {
        self.text = text
        self.color = color
    }

    var body: some View {
        Text(text)
            .foregroundColor(color)
            .font(.system(size: 13, weight: .bold))
            .multilineTextAlignment(.leading)
            .padding(.horizontal)
    }
}
