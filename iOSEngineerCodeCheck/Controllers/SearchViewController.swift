//
//  SearchViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    private let searchBar = UISearchBar()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    var items = [Repository.Item]()
    private var api = GithubAPI()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.placeholder = "Githubリポジトリの検索"
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        setupViews()
    }
    
    private func setupViews() {
        
        view.addSubview(searchBar)
        view.addSubview(tableView)
        
        searchBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor)
        tableView.anchor(top: searchBar.bottomAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor)
        
    }
    
    
}


extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        api.stopTask()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let text = searchBar.text,
              !text.isEmpty
        else { return }
        
        api.getRepositories(word: text) { [weak self] result in
            switch result {
            case .success(let repositories):
                self?.items = repositories
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let repository = items[indexPath.row]
        cell.textLabel?.text = repository.fullName
        cell.detailTextLabel?.text = repository.language
        cell.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        let resultVC = ResultViewController(item: items[indexPath.row])
        navigationController?.pushViewController(resultVC, animated: true)
        
    }
}
