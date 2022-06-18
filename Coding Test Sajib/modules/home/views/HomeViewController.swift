//
//  ViewController.swift
//  Coding Test Sajib
//
//  Created by MacBook Pro on 17/6/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    
    var STORY_STATUS: [String] = ["Most Viewed","Most Shared","Most Emailed"]
    
    lazy var articleViewModel: ArticlesViewModel = {
        return ArticlesViewModel()
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @IBAction func onSearchButtonClicked(_ sender: Any) {
        //self.performSegue(withIdentifier: Segues.segueHomeToSearch, sender: nil)
    }
    
}


extension HomeViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return STORY_STATUS.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Cells.articleTypesCellIdentifier, for: indexPath) as? HomeTableViewCell else{
            fatalError("Unknown cell")
        }
        
        cell.labelTitle.text = STORY_STATUS[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        articleViewModel.setSelectedIndex(indexPath: indexPath)
        print("selected postition \(indexPath.row)")
        self.performSegue(withIdentifier: Segues.segueHomeToArticleList, sender: nil)
        return indexPath
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? ArticleListViewController {
            vc.articleViewModel = self.articleViewModel
        }
        
        if let vc = segue.destination as? SearchViewController {
            vc.articleViewModel = self.articleViewModel
        }
        
    }
}
