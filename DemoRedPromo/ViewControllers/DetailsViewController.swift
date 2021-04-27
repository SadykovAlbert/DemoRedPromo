//
//  DetailsViewController.swift
//  DemoRedPromo
//
//  Created by Альберт Садыков on 23.04.2021.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var imageV: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    var newsItem: NewsItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    func updateUI(){
        
        guard newsItem != nil else{return}
        
        titleLabel.text = newsItem?.title
        textLabel.text = newsItem?.text
        dateLabel.text = newsItem?.date
        
        ImageManager.shared.getImageData(stringUrl: newsItem?.imageUrl) {[weak self] (imageData, _) in
            
            self?.imageV.image = UIImage(data: imageData)
        }
        
    }

    

}
