//
//  ImageManager.swift
//  DemoRedPromo
//
//  Created by Альберт Садыков on 26.04.2021.
//

import Foundation

class ImageManager{
    
    static let shared = ImageManager()
    private init(){}
    
    func getImageData(stringUrl: String?, completion: @escaping (Data, String) -> Void){
        guard
            let stringUrl = stringUrl,
            let imageUrl = URL(string: stringUrl)
        else
        {return}
        
        DispatchQueue.global(qos: .userInteractive).async {
            
            guard let imageData = try? Data(contentsOf: imageUrl) else {return}
            DispatchQueue.main.async {
                let stringUrl = "\(imageUrl)"
                completion(imageData, stringUrl)
            }
        }
        
    }
    
}
