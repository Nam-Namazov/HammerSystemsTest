//
//  NetworkService.swift
//  HammersSystemTestApp
//
//  Created by Намик on 10/18/22.
//

import UIKit

final class NetworkService {
    
    static let shared = NetworkService()
    
    private let urlString = "https://www.thecocktaildb.com/api/json/v1/1/search.php?f=a"
    
    private let session = URLSession.shared
    
    private init() {}
    
    func getData(completion: @escaping (Result<[Drink], Error>) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let dataTask = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let decoder = try JSONDecoder().decode(CoctailModel.self, from: data)
                completion(.success(decoder.drinks))
                
            } catch {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
    
    func getImage(completion: @escaping (Result<UIImage?, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let dataTask = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else {
                return
            }
            
            guard let data = data else {
                return
            }
            completion(.success(UIImage(data: data)))
        }
        dataTask.resume()
    }
}
