//
//  SearchViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by 史 翔新 on 2020/04/20.
//  Copyright © 2020 YUMEMI Inc. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate {
    
    private let searchBar = UISearchBar()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    var items = [Repository.Item]()
    var task: URLSessionTask?
    var word: String?
    
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
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        task?.cancel()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard word?.count != 0 else { return }
        
        let session = URLSession.shared
        let url = "https://api.github.com/search/repositories?q="
        word = searchBar.text ?? ""
        
        guard let percentEncoding = word?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL(string: url + percentEncoding) else {
            print("error")
            return
        }
        
        task = session.dataTask(with: url) { (data, response, _) in
            
            guard let data = data else {
                print("error")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let repository = try decoder.decode(Repository.self, from: data)
                let items = repository.items
                self.items = items
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print(error)
            }
            
        }
        task?.resume()
        
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "Detail"{
//            let detail = segue.destination as! ResultViewController
//            detail.searchViewController = self
//        }
//
//    }
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
//        print("タップされました")
//        index = indexPath.row
//        print(index)
        let resultVC = ResultViewController(item: items[indexPath.row])
     
        navigationController?.pushViewController(resultVC, animated: true)
    }
}
