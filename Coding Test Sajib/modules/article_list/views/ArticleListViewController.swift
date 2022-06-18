//
//  ArticleListViewController.swift
//  Coding Test Sajib
//
//  Created by MacBook Pro on 18/6/22.
//

import UIKit

class ArticleListViewController: UIViewController {

    
    var articleViewModel: ArticlesViewModel!
    var articles : [ArticleModel]? = nil
    var activityView: UIActivityIndicatorView?

    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchArticle()
    }
    

    func fetchArticle() {
        showActivityIndicator()
        articleViewModel.onCompleteLoading = { [weak self] (data) in
            print("hide progress bar")
            guard let self = self else { return }
            self.articles = data
            self.tableView.reloadData()
            self.hideActivityIndicator()
        }
        
        switch(articleViewModel.selectedArticleUrl){
            
        case .SEARCH_ARTICLE:
            articleViewModel.searchArticles()
            break
        default:
            articleViewModel.getArticles()
        }
    }
    
    
    func showActivityIndicator() {
        activityView = UIActivityIndicatorView(style: .large)
        activityView?.center = self.view.center
        self.view.addSubview(activityView!)
        activityView?.startAnimating()
    }
    
    func hideActivityIndicator(){
        if (activityView != nil){
            activityView?.stopAnimating()
        }
    }
}


extension ArticleListViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.articles?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.articleListCellIdentifier, for: indexPath) as? ArticleListCell else{
            fatalError("Unknown cell")
        }
        let data = articles?[indexPath.row]
        cell.labelTitle.text = data?.title
        cell.labelDatePublished.text = data?.publishedDate
        return cell
    }
    
}
