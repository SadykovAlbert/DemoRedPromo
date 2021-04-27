//
//  AllNewsListViewController.swift
//  DemoRedPromo
//
//  Created by Альберт Садыков on 23.04.2021.
//

import UIKit

class AllNewsListViewController: UIViewController, UITabBarControllerDelegate {

    @IBOutlet var searchController: UISearchController!
    @IBOutlet var tableView: UITableView!
    let myUrl = URL(string: "https://lenta.ru/rss")!
    var news: [NewsItem] = []
    var filteredNews: [NewsItem] = []

    private var isFiltering: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        loadRss(myUrl)
        //setFavStatus()
        self.tabBarController?.delegate = self
    }
//    func setFavStatus(){
//        for i in news{
//            news.
//        }
////        news.forEach{ $0.isFavourite = DataManager.shared.loadFavouriteStatus(for: $0.title)}
//    }
    
    func loadRss(_ url: URL){
        let myParser = NetworkManager().initWithUrl(url) as! NetworkManager
        news = myParser.news
            
        
        
            self.tableView.reloadData()
        
        
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
            if viewController.isKind(of: AllNewsListViewController.self as AnyClass) {
                let viewController  = tabBarController.viewControllers?[1] as! FavouriteListViewController
                viewController.news = self.news
            }

            return true
        }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        
        if segue.identifier == "DetailsVC"{
            let indexPath = sender as! IndexPath
            
            let newsItem = isFiltering ?
                filteredNews[indexPath.row] : news[indexPath.row]
            
            
            
            
            
            //let newsItem = news[indexPath.row]
            let detailsVC = segue.destination as! DetailsViewController
            detailsVC.newsItem = newsItem
        }
        
        
        
    }
    

}


extension AllNewsListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if isFiltering{
            return filteredNews.count
        }
        
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustemTableViewCell
        
        var newsItem: NewsItem
        
        if isFiltering{
            newsItem = filteredNews[indexPath.row]
            
        }else{
            newsItem = news[indexPath.row]
        }
        
        
        
        cell.configure(with: newsItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "DetailsVC", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favourite = favouriteSwipeAction(at: indexPath)
        return UISwipeActionsConfiguration(actions: [favourite])
    }
    
    func favouriteSwipeAction(at indexPath: IndexPath) -> UIContextualAction{
        
        
        //var newsItem = news[indexPath.row]
        var newsItem = isFiltering ?
            filteredNews[indexPath.row] : news[indexPath.row]
        
        let action = UIContextualAction(style: .normal, title: "Favourite") { (action, view, completion) in
            
            newsItem.isFavourite.toggle()
            
            if (self.isFiltering == true) {
                self.filteredNews[indexPath.row] = newsItem

            }else{
                
                self.news[indexPath.row] = newsItem
            }
            
            DataManager.shared.saveFavouriteStatus(for: newsItem.title, with: newsItem.isFavourite)

            
            completion(true)
        }
        
        
        
        newsItem.isFavourite = DataManager.shared.loadFavouriteStatus(for: newsItem.title)
        action.backgroundColor = newsItem.isFavourite ? .systemPink : .systemGray
        action.image = UIImage(systemName: "heart")
        
        return action
    }
}



extension AllNewsListViewController: UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredNews = news.filter({ (newsItem) -> Bool in
            return newsItem.title.lowercased().contains(searchText.lowercased())
        })
        
        
        isFiltering  = true
        tableView.reloadData()
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltering  = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
        tableView.reloadData()
        
    }
    
    
   
}
