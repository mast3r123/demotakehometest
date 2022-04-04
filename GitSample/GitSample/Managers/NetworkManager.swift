//
//  NetworkManager.swift
//  GitSample
//
//  Created by master on 4/4/22.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    let baseUrl: String = "https://api.github.com"
    let perPageFollower = 100
    
    private init() {
        
    }
    
    func getFollowers(for userName: String, page: Int, completion: @escaping([Follower]?, ErrorMessage?) -> Void) {
        let endPoint = baseUrl + "/users/\(userName)/followers?per_page=\(perPageFollower)&page=\(page)"
        
        print(endPoint)
        
        guard let url = URL(string: endPoint) else {
            completion(nil, .invalidUsername)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(nil, .unableToComplete)
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    completion(nil, .invalidResponse)
                return
            }
            
            guard let data = data else {
                completion(nil, .invalidData)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                
                completion(followers, nil)
            } catch {
                debugPrint(error)
                completion(nil, .invalidData)
            }
        }
        
        task.resume()
    }
}
