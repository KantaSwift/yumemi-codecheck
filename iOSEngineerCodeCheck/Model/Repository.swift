//
//  Repository.swift
//  iOSEngineerCodeCheck
//
//  Created by 上條栞汰 on 2022/09/12.
//  Copyright © 2022 YUMEMI Inc. All rights reserved.
//

import UIKit

struct Repository: Decodable {
    
    let items: [Item]
    
    struct Item: Decodable {
        
        let language: String?
        let stargazersCount: Int
        let watchersCount: Int
        let forksCount: Int
        let openIssuesCount: Int
        let fullName: String
        let owner: Owner
        
        struct Owner: Decodable {
            let avatarUrl: String
        }
    }
    
}
