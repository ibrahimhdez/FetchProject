//
//  ContentView.swift
//  FetchProject
//
//  Created by Ibrahim Hernández Jorge on 8/11/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = FetchViewModel()
    @State private var willMoveToMealScreen = false
    @State private var selectedMeal: Meal?

    var body: some View {
        NavigationStack {
            ScrollView {
                header
                recipesView
            }
            .navigationDestination(isPresented: $willMoveToMealScreen, destination: {
                if let selectedMeal {
                    MealDetailslView(meal: selectedMeal)
                }
            })
        }
        .onAppear {
            Task {
                await viewModel.fetchMeals()
            }
        }
    }

    private var header: some View {
        HStack {
            Text("My Recipes:")
                .font(.system(size: 45, weight: .bold))
                .multilineTextAlignment(.leading)
                .padding(.all)
            Spacer()
        }
    }

    private var recipesView: some View {
        VStack(spacing: 20) {
            ForEach(viewModel.meals, id: \.self) { meal in
                MealCell(meal: meal)
                    .padding(.horizontal, 20)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedMeal = meal
                        willMoveToMealScreen.toggle()
                    }
            }
        }
    }
}
