//
//  NetworkManager.swift
//  BookStoreApp
//
//  Created by Jimin on 12/31/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private let apiKey = "7c8f8101e3e0b20490cfabe44f91419a"
    private let baseURL = "https://dapi.kakao.com/v3/search/book"
    
    private init() {}
    
    func fetchBooks(query: String, completion: @escaping (Result<[Book], Error>) -> Void) {
        
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: "\(baseURL)?query=\(encodedQuery)") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = ["Authorization": "KakaoAK \(apiKey)"]
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(BookResponseModel.self, from: data)
                    completion(.success(response.documents))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
