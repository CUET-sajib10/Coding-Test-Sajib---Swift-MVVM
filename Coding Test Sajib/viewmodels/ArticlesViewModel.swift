//
//  ArticlesViewModel.swift
//  Coding Test Sajib
//
//  Created by MacBook Pro on 18/6/22.
//

import Foundation

class ArticlesViewModel{
    
    var selectedArticleUrl: HttpURL?
    var searchText: String?
    
    var articleResponseModel: ArticleResponseModel!
    var onCompleteLoading: (([ArticleModel]) -> Void)?
    
    func setSelectedIndex(indexPath: IndexPath){
        
        switch indexPath.row {
        case 0:
            selectedArticleUrl = HttpURL.MOST_VIEWED
            break
        case 1:
            selectedArticleUrl = HttpURL.MOST_SHARED
            break
        case 2:
            selectedArticleUrl = HttpURL.MOST_EMAILED
            break
        default:
            selectedArticleUrl = HttpURL.SEARCH_ARTICLE
        }
    }
    
    
    func getArticles(){
        
        RequestManager.request(using: selectedArticleUrl!.url, params: nil, type: .get, success: {
            [weak self] response in
            guard let self = self else { return }
            
            do{
                    let json = String(data: response, encoding: .utf8)
                    print("Response: \(String(describing: json))")
                
                let responseData = try JSONDecoder().decode(ArticleResponseModel.self, from: response)
                    //self.articles = responseData.results.map(Result.init)
                    
                let articles = responseData.results.flatMap({
                    ArticleModel(title: $0.title, publishedDate: $0.publishedDate)
                })

                self.onCompleteLoading?(articles)
                
            }catch let error {
                print(error.localizedDescription)
            }
            
        }, failure: {
            error in
            switch error {
                
            case .noInternet:
                print("no internet")
                break
                
            case .networkProblem:
                print("network problem")
                break
                
            case .errorDescription(_):
                print("error")
                break
            }
        })
    }
    
    func searchArticles(){
        
        guard let searchText = searchText else {
            print("Enter search text")
            return
        }

        let url = selectedArticleUrl?.getSearchUrl(searchText: searchText)
        RequestManager.request(using: url!, params: nil, type: .get, success: {
            [weak self] response in
            guard let self = self else { return }
            
            do{
                    let json = String(data: response, encoding: .utf8)
                    print("Response: \(String(describing: json))")
                let responseData = try JSONDecoder().decode(SearchResponseModel.self, from: response)
                let list = responseData.response.docs.flatMap({ item  in
                    ArticleModel(title: item.headline.main, publishedDate: item.pubDate)
                })
                self.onCompleteLoading?(list)
            }catch let error {
                print(error.localizedDescription)
            }
            
        }, failure: {
            error in
            switch error {
                
            case .noInternet:
                print("no internet")
                break
                
            case .networkProblem:
                print("network problem")
                break
                
            case .errorDescription(_):
                print("error")
                break
            }
        })
    }
}
