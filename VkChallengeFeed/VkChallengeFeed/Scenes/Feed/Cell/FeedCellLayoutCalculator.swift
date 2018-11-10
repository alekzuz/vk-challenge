//
//  FeedCellLayoutCalculator.swift
//  VkChallengeFeed
//
//  Created by Aleksei Sakharov on 10/11/2018.
//  Copyright © 2018 sakharov. All rights reserved.
//

import UIKit

protocol FeedCellLayoutCalculatorProtocol {
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
    
    struct Constants {
        static let cardInsets = UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
        static let postLabelInsets = UIEdgeInsets(top: 58, left: 12, bottom: 10, right: 12)
        static let countersPlaceholderHeight: CGFloat = 44
    }
    
    struct Sizes: FeedCellSizes {
        let postLabelFrame: CGRect
        let attachmentFrame: CGRect
        let counterPlaceholderFrame: CGRect
        let totalHeight: CGFloat
    }
    
    private let screenWidth: CGFloat
    private let systemFont15 = UIFont.systemFont(ofSize: 15)
    
    init(screenWidth: CGFloat) {
        self.screenWidth = screenWidth
    }
    
    func sizes(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes  {
        let fittingWidth = screenWidth - Constants.cardInsets.left - Constants.cardInsets.right
        
        var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInsets.right,
                                                    y: Constants.postLabelInsets.top),
                                    size: CGSize.zero)
        if let text = postText {
            let width = fittingWidth - Constants.postLabelInsets.left - Constants.postLabelInsets.right
            let height = text.height(fittingWidth: width, font: systemFont15)
            postLabelFrame.size = CGSize(width: width, height: height)
        }
        
        let attachmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInsets.top : postLabelFrame.maxY + Constants.postLabelInsets.bottom
        var attachmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop), size: CGSize.zero)
        if let attachment = photoAttachment {
            let ratio = CGFloat(attachment.height / attachment.width)
            attachmentFrame.size = CGSize(width: fittingWidth, height: fittingWidth * ratio)
        }
        
        let counterPlaceholderFrame = CGRect(x: 0,
                                             y: max(postLabelFrame.maxY, attachmentFrame.maxY),
                                             width: fittingWidth,
                                             height: Constants.countersPlaceholderHeight)
        
        let totalHeight = counterPlaceholderFrame.maxY + Constants.cardInsets.bottom
        
        return Sizes(postLabelFrame: postLabelFrame,
                     attachmentFrame: attachmentFrame,
                     counterPlaceholderFrame: counterPlaceholderFrame,
                     totalHeight: totalHeight)
    }
    
}
