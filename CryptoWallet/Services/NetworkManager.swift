//
//  NetworkManager.swift
//  CryptoWallet
//
//  Created by Дмитрий Дуров on 12.01.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

final class NetworkManager {
    
    // MARK: - Public properties
    
    static let shared = NetworkManager()
    
    // MARK: - Initializers
    
    private init() {}
    
    // MARK: - Public methods
    
    func fetch<T: Decodable>(_ type: T.Type,  for url: String?, completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard let urlString = url, let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No Description")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let type = try decoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(type))
                }
            } catch {
                completion(.failure(.decodingError))
                print(error.localizedDescription)
            }
        }.resume()
    }
}
