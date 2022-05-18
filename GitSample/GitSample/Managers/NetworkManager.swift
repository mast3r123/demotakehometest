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
                decoder.dateDecodingStrategy = .iso8601
                
                let user = try decoder.decode(User.self, from: data)
                
                completion(.success(user))
            } catch {
                debugPrint(error)
                completion(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    func downloadImage(from urlString: String, completion: @escaping(UIImage?) -> Void) {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        
        guard let url = URL(string: urlString) else { completion(nil); return }
        
        let task = URLSession.shared.dataTask(with: url) {  [weak self] data, response, error in
            
            guard let self = self, error == nil, let response = response as? HTTPURLResponse, response.statusCode == 200, let data = data, let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
            
            completion(image)
        }
        task.resume()
    }
}
