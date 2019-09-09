//
//  countries.swift
//  concurrency
//
//  Created by albert coelho oliveira on 9/3/19.
//  Copyright © 2019 albert coelho oliveira. All rights reserved.
//

import Foundation

struct Countries: Codable {
    let name: String
    let capital: String
    let population: Int
    let flag: String
    
    static func getCountry(completionHandler: @escaping (Result<[Countries],AppError>) -> () ) {
        let url = "https://restcountries.eu/rest/v2/name/united"
        NetworkManager.shared.fetchData(urlString: url) { (result) in
            switch result {
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
                do {
                    let decodedCountry = try JSONDecoder().decode([Countries].self, from: data)
                    completionHandler(.success(decodedCountry))
                } catch {
                    completionHandler(.failure(.badJSONError))
                    print(error)
                }
            }
        }
    }
}

