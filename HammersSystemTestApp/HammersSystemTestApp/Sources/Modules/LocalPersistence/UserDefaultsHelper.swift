//
//  UserDefaultsHelper.swift
//  HammersSystemTestApp
//
//  Created by Намик on 10/19/22.
//

import UIKit

final class UserDefaultsHelper {
    
    static var getAllCategories: [String]? {
        if let objects = UserDefaults.standard.value(
            forKey: "categories"
        ) as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(
                Array.self, from: objects
            ) as [String] {
                return objectsDecoded
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    static func saveAllCategories(allObjects: [String]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(allObjects) {
            UserDefaults.standard.set(encoded,
                                      forKey: "categories")
        }
    }
    
    static func removeAllCategories() {
        UserDefaults.standard.removeObject(forKey: "categories")
    }
    
    static var getAllDrinks: [Drink]? {
        if let objects = UserDefaults.standard.value(
            forKey: "drinks"
        ) as? Data {
            let decoder = JSONDecoder()
            if let objectsDecoded = try? decoder.decode(
                Array.self, from: objects
            ) as [Drink] {
                return objectsDecoded
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
    
    static func saveAllDrinks(allObjects: [Drink]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(allObjects) {
            UserDefaults.standard.set(encoded,
                                      forKey: "drinks")
        }
    }
    
    static func removeAllDrinks() {
        UserDefaults.standard.removeObject(forKey: "drinks")
    }
}
