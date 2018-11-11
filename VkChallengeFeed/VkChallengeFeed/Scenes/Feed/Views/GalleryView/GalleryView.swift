//
//  GalleryView.swift
//  VkChallengeFeed
//
//  Created by Aleksei Sakharov on 11/11/2018.
//  Copyright © 2018 sakharov. All rights reserved.
//

import UIKit

final class GalleryView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    struct Constants {
        static let itemSideInset: CGFloat = 12
        static let pageControlHeight: CGFloat = 37
    }
    
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var pageControl: UIPageControl!
    
    private var photos = [FeedCellPhotoAttachmentViewModel]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "GalleryItem", bundle: nil), forCellWithReuseIdentifier: GalleryItem.reuseId)
        
        pageControl.pageIndicatorTintColor = UIColor(red: 81/255, green: 129/255, blue: 184/255, alpha: 0.3)
        pageControl.currentPageIndicatorTintColor = UIColor(red: 81/255, green: 129/255, blue: 184/255, alpha: 1)
    }
    
    func setItemSize(_ size: CGSize) {
        let flowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        flowLayout.itemSize = size
    }
    
    func set(photos: [FeedCellPhotoAttachmentViewModel]) {
        self.photos = photos
        pageControl.numberOfPages = photos.count
        pageControl.currentPage = 0
        collectionView.contentOffset = CGPoint.zero
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryItem.reuseId, for: indexPath) as! GalleryItem
        cell.set(imageUrl: photos[indexPath.row].photoUrlString)
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let centerX = collectionView.contentOffset.x + collectionView.frame.size.width / 2
        let centerY = collectionView.frame.size.height / 2
        let center = CGPoint(x: centerX, y: centerY)
        if let indexPath = collectionView.indexPathForItem(at: center) {
            pageControl.currentPage = indexPath.row
        }
    }
    
}
