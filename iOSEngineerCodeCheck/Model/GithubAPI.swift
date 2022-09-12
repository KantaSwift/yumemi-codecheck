//
//  GithubAPI.swift
//  iOSEngineerCodeCheck
//
//  Created by 上條栞汰 on 2022/09/12.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

struct GithubAPI {
    
  private var task: URLSessionTask?
    
    mutating func getRepositories(word: String, completion: @escaping (Result<[Repository.Item], Error>) -> () ) {
        
        let session = URLSession.shared
        let url = "https://api.github.com/search/repositories?q="
        
        guard let percentEncoding = word.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: url + percentEncoding) else {
            completion(.failure("invalid url"))
            return
        }
        
        task = session.dataTask(with: url) { (data, response, _) in
            
            guard let data = data else {
                completion(.failure("data is nil"))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let repository = try decoder.decode(Repository.self, from: data)
                let items = repository.items
                completion(.success(items))
            } catch {
                print(error)
                completion(.failure(error))
            }
            
        }
        task?.resume()
        
    }
    
    
    func stopTask() {
        task?.cancel()
    }
    
    
    
}


