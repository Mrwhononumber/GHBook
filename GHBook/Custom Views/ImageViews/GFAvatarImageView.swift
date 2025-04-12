//
//  GFAvatarImageView.swift
//  GHBook
//
//  Created by Basem Elkady on 4/3/25.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    //MARK: - Properties
    
    let cache = NetworkManager.shared.cache
    let placeHolderImage = UIImage(named: "avatar-placeholder")

    
    //MARK: - Initializers
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Configuration
    
    private func configure(){
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeHolderImage  // Set a default image while downloading the avatar image, and if the download fails
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    //MARK: - Image Downloading
    
    /// Downloads the avatar image from a URL string, with caching.
    func downloadImage(from urlString: String) {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) {[weak self] data, response, error in
            guard let self = self else { return }
            if error != nil { return } /// no need to handle errors visibly, we fall back to placeholder
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
           
            guard let image = UIImage(data: data) else { return }
            cache.setObject(image, forKey: cacheKey)
             
            DispatchQueue.main.async {
                self.image = image
            }
        }
        task.resume()
    }
}
