//
//  CustemTableViewCell.swift
//  DemoRedPromo
//
//  Created by Альберт Садыков on 26.04.2021.
//


import UIKit

class CustemTableViewCell: UITableViewCell{
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var imageV: UIImageView!
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var stringUrl: String?
//        didSet{
//            self.imageV.image = nil
//            updateUI()
//        }
    
    
    
    func configure(with newsItem: NewsItem){
        
        stringUrl = newsItem.imageUrl
        nameLabel.text = newsItem.title
        dateLabel.text = newsItem.date
        
        self.imageV.image = nil
        updateUI()
        
    }
    
    
    func updateUI(){
        
        spinner.startAnimating()
        self.spinner.isHidden = false
        
        ImageManager.shared.getImageData(stringUrl: stringUrl) {[weak self] (imageData, stringUrl) in
            guard self?.stringUrl == stringUrl else {return}
            self?.imageV?.image = UIImage(data: imageData)
            self?.spinner.stopAnimating()
            self?.spinner.isHidden = true
        }
        
    }
    
}
