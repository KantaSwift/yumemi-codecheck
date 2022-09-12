//
//  ImageGetter.swift
//  iOSEngineerCodeCheck
//
//  Created by 上條栞汰 on 2022/09/12.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

struct ImageGetter {
    
    func getImage(imageUrl: String, completion: @escaping (Result<UIImage, Error>) -> () ) {
   
        guard  let url = URL(string: imageUrl) else {
            completion(.failure("invalid url"))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, _) in
            
            guard let data = data,
                  let data = UIImage(data: data)
            else {
                completion(.failure("data is nil"))
                return
            }
            
            let image = data
            completion(.success(image))
        }
        task.resume()
    
    }
    
}

extension String: LocalizedError {}
