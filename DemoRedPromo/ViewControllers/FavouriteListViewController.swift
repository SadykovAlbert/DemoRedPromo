//
//  FavouriteListViewController.swift
//  DemoRedPromo
//
//  Created by Альберт Садыков on 23.04.2021.
//

import UIKit

class FavouriteListViewController: UIViewController {

    @IBOutlet var tableView: UITableView!

    var news: [NewsItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("viewDidLoad")

        
    }
    

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //print("viewDidAppear")

        print("news.count = \(news.count) in favVC")
        
        print(UserDefaults.standard.dictionaryRepresentation().values)        //print(news.first?.date)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension FavouriteListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CustemTableViewCell
        
        var newsItem: NewsItem
        
       
            newsItem = news[indexPath.row]
        
        
        
        cell.configure(with: newsItem)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
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
        
        
        var newsItem =  news[indexPath.row]
        
        let action = UIContextualAction(style: .normal, title: "Favourite") { (action, view, completion) in
            
            newsItem.isFavourite.toggle()
            
           
                self.news[indexPath.row] = newsItem
            
            
            completion(true)
        }
        
        action.backgroundColor = newsItem.isFavourite ? .systemPink : .systemGray
        action.image = UIImage(systemName: "heart")
        
        return action
    }
}
