//
//  FeedCellLayoutCalculator.swift
//  VkChallengeFeed
//
//  Created by Aleksei Sakharov on 10/11/2018.
//  Copyright © 2018 sakharov. All rights reserved.
//

import UIKit

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, isFullSizedPost: Bool, photoAttachments: [FeedCellPhotoAttachmentViewModel]) -> FeedCellSizes
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    
    struct Constants {
        static let minifiedPostLines = 6
        static let minifiedPostLimitLines = 8
        static let cardInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
        static let postLabelInsets = UIEdgeInsets(top: 58, left: 12, bottom: 10, right: 12)
        static let moreTextButtonInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        static let moreTextButtonSize = CGSize(width: 170, height: 30)
        static let countersPlaceholderHeight: CGFloat = 44
    }
    
    struct Sizes: FeedCellSizes {
        let postLabelFrame: CGRect
        let moreTextButtonFrame: CGRect
        let attachmentFrame: CGRect
        let galleryItemSize: CGSize
        let counterPlaceholderFrame: CGRect
        let totalHeight: CGFloat
    }
    
    private let screenWidth: CGFloat
    private let postFont = UIFont.systemFont(ofSize: 15)
    
    init(screenWidth: CGFloat) {
        self.screenWidth = screenWidth
    }
    
    func sizes(postText: String?, isFullSizedPost: Bool, photoAttachments: [FeedCellPhotoAttachmentViewModel]) -> FeedCellSizes  {
        let fittingWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        var showMoreTextButton = false
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.right,
                                                    y: Constants.postLabelInsets.top),
                                    size: CGSize.zero)
        if let text = postText, !text.isEmpty {
            let width = fittingWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            var height = text.height(fittingWidth: width, font: postFont)
            let limitHeight = postFont.lineHeight * CGFloat(Constants.minifiedPostLimitLines)
            if !isFullSizedPost && height > limitHeight {
                height = postFont.lineHeight * CGFloat(Constants.minifiedPostLines)
                showMoreTextButton = true
            }
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        var moreTextButtonSize = CGSize.zero
        if showMoreTextButton {
            moreTextButtonSize = Constants.moreTextButtonSize
        }
        let moreTextButtonOrigin = CGPoint(x: Constants.moreTextButtonInsets.left, y: postLabelFrame.maxY)
        let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)
        
        let attachmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInsets.top : moreTextButtonFrame.maxY + Constants.postLabelInsets.bottom
        var attachmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop), size: CGSize.zero)
        var galleryItemSize = CGSize.zero
        if let attachment = photoAttachments.first {
            let ratio = CGFloat(attachment.height / attachment.width)
            if photoAttachments.count == 1 {
                attachmentFrame.size = CGSize(width: fittingWidth, height: fittingWidth * ratio)
            } else {
                let itemWidth = fittingWidth - GalleryView.Constants.itemSideInset * 2
                let itemHeight = itemWidth * ratio
                galleryItemSize = CGSize(width: itemWidth, height: itemHeight)
                let attachmentHeight = itemWidth * ratio + GalleryView.Constants.pageControlHeight
                attachmentFrame.size = CGSize(width: fittingWidth, height: attachmentHeight)
            }
        }
        
        let counterPlaceholderFrame = CGRect(x: 0,
                                             y: max(postLabelFrame.maxY, attachmentFrame.maxY),
                                             width: fittingWidth,
                                             height: Constants.countersPlaceholderHeight)
        
        let totalHeight = counterPlaceholderFrame.maxY + Constants.cardInsets.bottom
        
        return Sizes(postLabelFrame: postLabelFrame,
                     moreTextButtonFrame: moreTextButtonFrame,
                     attachmentFrame: attachmentFrame,
                     galleryItemSize: galleryItemSize,
                     counterPlaceholderFrame: counterPlaceholderFrame,
                     totalHeight: totalHeight)
    }
    
}
