//
//  SearchViewController.swift
//  Coding Test Sajib
//
//  Created by MacBook Pro on 18/6/22.
//

import UIKit

class SearchViewController: UIViewController {

    var articleViewModel: ArticlesViewModel!
    
    @IBOutlet var uiSearchBar: UISearchBar!
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        articleViewModel.selectedArticleUrl = HttpURL.SEARCH_ARTICLE
        articleViewModel.searchText = uiSearchBar.text
        if let vc = segue.destination as? ArticleListViewController {
            vc.articleViewModel = self.articleViewModel
        }
    }
}
