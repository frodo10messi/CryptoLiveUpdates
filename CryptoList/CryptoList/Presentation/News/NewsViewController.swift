//
//  NewsViewController.swift
//  CryptoList
//
//  Created by abdul ahad  on 11/02/22.
//

import UIKit
import SafariServices

class NewsViewController: UITableViewController {
    var viewModel: NewsViewModel?
    
    var news: [News] = [] {
        didSet{
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News"
        
        viewModel?.onNewsLoad = { [weak self] news in
            self?.news = news
        }
        
        viewModel?.onNewsError = { [weak self] error in
            
            self?.handle(error) {
                self?.viewModel?.fetchNews()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel?.fetchNews()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        present(SFSafariViewController(url: news[indexPath.row].url), animated: true)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell") as! NewsCell
        let news = news[indexPath.row]
        let vm = NewsItemViewModel(news: news)
        cell.configure(vm)
        return cell
    }
    
}
