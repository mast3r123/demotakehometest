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
    let decoder = JSONDecoder()
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    
    func getFollowers(for userName: String, page: Int) async throws -> [Follower] {
        let endPoint = baseUrl + "/users/\(userName)/followers?per_page=\(perPageFollower)&page=\(page)"
        
        print(endPoint)
        
        guard let url = URL(string: endPoint) else {
            throw GFError.invalidUsername
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GFError.invalidUsername
        }
        
        do {
            return try decoder.decode([Follower].self, from: data)
        } catch {
            throw GFError.invalidData
        }
    }
    
    
    func getUserInfo(for userName: String) async throws -> User {
        let endPoint = baseUrl + "/users/\(userName)"
        
        print(endPoint)
        
        guard let url = URL(string: endPoint) else {
            throw GFError.invalidUsername
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GFError.invalidUsername
        }
        
        do {
            return try decoder.decode(User.self, from: data)
        } catch {
            throw GFError.invalidData
        }
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
