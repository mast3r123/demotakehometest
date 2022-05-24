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
        
        guard let url = URL(string: endPoint) else {
            throw GFError.invalidUsername
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GFError.invalidResponse
        }
        
        do {
            return try decoder.decode(User.self, from: data)
        } catch {
            throw GFError.invalidData
        }
    }
    
    func downloadImage(from urlString: String) async -> UIImage? {
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            return image
        }
        
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else {
                return nil
            }
            self.cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
}
