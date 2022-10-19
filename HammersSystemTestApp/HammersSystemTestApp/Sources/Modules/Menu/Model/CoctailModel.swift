//
//  CoctailModel.swift
//  HammersSystemTestApp
//
//  Created by Намик on 10/18/22.
//

import UIKit

public struct CoctailModel: Codable {
    var drinks: [Drink]
}

public struct Drink: Codable {
    let strDrink: String?
    let strCategory: String?
    let strInstructions: String?
    let strDrinkThumb: String
    var drinkThumbImageData: Data?
}
