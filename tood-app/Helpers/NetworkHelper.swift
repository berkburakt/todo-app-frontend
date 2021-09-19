//
//  NetworkHelper.swift
//  tood-app
//
//  Created by Berk Burak Tasdemir on 9/18/21.
//

import SwiftUI

extension URLSession {
    static func put(url: String,
                       completion: @escaping (Result<Void, Error>) -> Void
    ) {
        guard let URL = URL(string: url) else {
            completion(.failure(NetworkError.invalidUrl))
            return
        }
        
        var request = URLRequest(url: URL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "PUT"
        
        let task = self.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(NetworkError.invalidData))
                print("Error: \(error.localizedDescription)")
                return
            }
            
            completion(.success(()))
        }
        
        task.resume()
    }
    
    static func delete(url: String,
                       completion: @escaping (Result<Void, Error>) -> Void
    ) {
        guard let URL = URL(string: url) else {
            completion(.failure(NetworkError.invalidUrl))
            return
        }
        
        var request = URLRequest(url: URL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "DELETE"
        
        let task = self.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(NetworkError.invalidData))
                print("Error: \(error.localizedDescription)")
                return
            }
            
            completion(.success(()))
        }
        
        task.resume()
    }
    
    static func post<T: Codable>(url: String,
                                  model: T,
                                  completion: @escaping (Result<Void, Error>) -> Void
    ) {
        guard let encoded = try? JSONEncoder().encode(model) else {
            completion(.failure(NetworkError.invalidModel))
            return
        }
        
        guard let URL = URL(string: url) else {
            completion(.failure(NetworkError.invalidUrl))
            return
        }
        
        var request = URLRequest(url: URL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        let task = self.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(NetworkError.invalidData))
                print("Error: \(error.localizedDescription)")
                return
            }
            
            completion(.success(()))
        }
        
        task.resume()
    }
    
    static func request<T: Codable>(url: String,
                                  expecting: T.Type,
                                  completion: @escaping (Result<T, Error>) -> Void
    ) {
        guard let URL = URL(string: url) else {
            completion(.failure(NetworkError.invalidUrl))
            return
        }
        
        let task = self.shared.dataTask(with: URL) { data, _, error in
            guard let data = data else {
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.failure(NetworkError.invalidData))
                }
                return
            }
                        
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}
