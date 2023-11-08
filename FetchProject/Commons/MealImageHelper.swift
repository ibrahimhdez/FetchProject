//
//  MealImageHelper.swift
//  FetchProject
//
//  Created by Ibrahim Hernández Jorge on 8/11/23.
//

import SwiftUI

class MealImageHelper {
    private var cacheImages: [String: Image] = [:]
    static let shared: MealImageHelper = {
        let instance = MealImageHelper()
        return instance
    }()

    func getImage(for id: String?) -> Image? {
        guard let id else { return nil }
        return cacheImages[id]
    }

    func storeImage(for id: String?, with image: Image) {
        guard let id else { return }
        cacheImages[id] = image
    }
}
