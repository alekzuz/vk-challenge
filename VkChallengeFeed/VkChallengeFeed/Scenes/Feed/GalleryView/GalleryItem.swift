//
//  GalleryItem.swift
//  VkChallengeFeed
//
//  Created by Aleksei Sakharov on 11/11/2018.
//  Copyright © 2018 sakharov. All rights reserved.
//

import UIKit

final class GalleryItem: UICollectionViewCell {
    
    @IBOutlet private var imageView: WebImageView!
    
    static let reuseId = "GalleryItem"
    
    func set(imageUrl: String?) {
        imageView.set(imageUrl: imageUrl)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
