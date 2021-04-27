//
//  NetworkManager.swift
//  DemoRedPromo
//
//  Created by Альберт Садыков on 23.04.2021.
//

import Foundation


class NetworkManager: NSObject, XMLParserDelegate {
    
    //    static let shared = NetworkManager()
    //    private init(){}
    
    var news: [NewsItem] = []
    
    var tempNewsItem: NewsItem? = nil
    var tempElement: String?
    
    var parser = XMLParser()
    //var news = NSMutableArray()
    
    func initWithUrl(_ url: URL) -> AnyObject{
        startParse(url)
        return self
    }
    
    func startParse(_ url: URL){
        news = []
        parser = XMLParser(contentsOf: url)!
        parser.delegate = self
//        parser.shouldProcessNamespaces = false
//        parser.shouldReportNamespacePrefixes = false
//        parser.shouldResolveExternalEntities = false
        parser.parse()
        
    }
    
//    func allNews() -> NSMutableArray{
//        return news
//    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parse error: \(parseError)")
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        tempElement = elementName
        
        if elementName == "item"{
            tempNewsItem = NewsItem(title: "", text: "", date: "", imageUrl: "")
        }
        
        if elementName == "enclosure"{
            if let urlString = attributeDict["url"] {
                tempNewsItem?.imageUrl = urlString
            }
        }
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "item"{
            if let newsItem = tempNewsItem{
                news.append(newsItem)
            }
            tempNewsItem = nil
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if let newsItem = tempNewsItem{
            switch tempElement {
            case "title":
                tempNewsItem?.title = newsItem.title + string
            case "description":
                tempNewsItem?.text = newsItem.text! + string
            case "pubDate":
                tempNewsItem?.date = newsItem.date! + string
//            case "enclosure":
//
//                tempNewsItem?.imageUrl = newsItem.imageUrl! + string
            default :
                return
                
            }
        }
        
    }
}
