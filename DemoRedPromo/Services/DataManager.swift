//
//  DataManager.swift
//  DemoRedPromo
//
//  Created by Альберт Садыков on 26.04.2021.
//

import Foundation

class DataManager {
    
    static let shared = DataManager()
    
    private let userDefaults = UserDefaults()
    
    func saveFavourite(for newsItemTitle: String, with newsItem: NewsItem) {
        userDefaults.setValue(newsItem, forKey: newsItemTitle)
    }
    
    func loadFavourite(for newsItemTitle: String) -> NewsItem? {
        return userDefaults.value(forKey: newsItemTitle) as? NewsItem
    }
    
    func saveFavouriteStatus(for newsItemTitle: String, with status: Bool) {
        userDefaults.set(status, forKey: newsItemTitle)
    }
    
    func loadFavouriteStatus(for newsItemTitle: String) -> Bool {
        return userDefaults.bool(forKey: newsItemTitle)
    }
    
}
