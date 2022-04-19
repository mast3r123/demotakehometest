//
//  NetworkManager.swift
//  GitSample
//
//  Created by master on 4/4/22.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    private let baseUrl: String = "https://api.github.com"
    let perPageFollower = 100
    let cache = NSCache<NSString, UIImage>()
    
    private init() {
        
    }
    
    func getFollowers(for userName: String, page: Int, completion: @escaping(Result<[Follower], GFError>) -> Void) {
        let endPoint = baseUrl + "/users/\(userName)/followers?per_page=\(perPageFollower)&page=\(page)"
        
        print(endPoint)
        
        guard let url = URL(string: endPoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidUsername))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                
                completion(.success(followers))
            } catch {
                debugPrint(error)
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func getUserInfo(for userName: String, completion: @escaping(Result<User, GFError>) -> Void) {
        let endPoint = baseUrl + "/users/\(userName)"
        
        print(endPoint)
        
        guard let url = URL(string: endPoint) else {
            completion(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidUsername))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let user = try decoder.decode(User.self, from: data)
                
                completion(.success(user))
            } catch {
                debugPrint(error)
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
