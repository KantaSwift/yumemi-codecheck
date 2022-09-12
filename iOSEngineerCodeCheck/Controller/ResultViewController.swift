//
//  ResultViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/21.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    private let imageView = UIImageView()
    private let titleLabel = InfoLabel(size: 20, weight: .heavy)
    private let languageLabel = InfoLabel(size: 18, weight: .bold)
    private let starsLabel = InfoLabel(size: 14, weight: .regular)
    private let watchersLabel = InfoLabel(size: 14, weight: .regular)
    private let forksLabel = InfoLabel(size: 14, weight: .regular)
    private let issuesLabel = InfoLabel(size: 14, weight: .regular)
    private let item: Repository.Item
    
    init(item: Repository.Item ) {
        
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let language = item.language {
            languageLabel.text = "Written in \(language)"
        } else {
            languageLabel.text = "No Language"
        }
        starsLabel.text = "\(item.stargazersCount) stars"
        watchersLabel.text = "\(item.watchersCount) watchers"
        forksLabel.text = "\(item.forksCount) forks"
        issuesLabel.text = "\(item.openIssuesCount) open issues"
        
        getImage()
        setupView()
        
    }
    
    private func setupView() {
        
        let infoStackView = UIStackView(arrangedSubviews: [starsLabel, watchersLabel, forksLabel, issuesLabel])
        infoStackView.axis = .vertical
        
        let baseStackView = UIStackView(arrangedSubviews: [languageLabel, infoStackView])
        baseStackView.axis = .horizontal
        
        view.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(baseStackView)
        
        imageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, leftPadding: 20, rightPadding: 20)
        
        titleLabel.anchor(top: imageView.bottomAnchor, left: imageView.leftAnchor, right: imageView.rightAnchor, topPadding: 15)
        
        baseStackView.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, topPadding: 15)
        
        
    }
    
    func getImage() {
        
       
        titleLabel.text = item.fullName
        
        let imageURL = item.owner.avatarUrl
        
        guard  let url = URL(string: imageURL) else {
            print("error")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, _) in
            
            guard let data = data else {
                print("data is nil")
                return
            }
            
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
        
        task.resume()
    }
}
