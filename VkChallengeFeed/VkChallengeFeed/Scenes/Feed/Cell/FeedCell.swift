//
//  FeedCell.swift
//  VkChallengeFeed
//
//  Created by Aleksei Sakharov on 10/11/2018.
//  Copyright © 2018 sakharov. All rights reserved.
//

import UIKit

protocol FeedCellViewModel {
    var iconUrlString: String { get }
    var name: String { get }
    var date: String { get }
    var text: String? { get }
    var moreTextTitle: String? { get }
    var likes: String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var views: String? { get }
    var photoAttachment: FeedCellPhotoAttachmentViewModel? { get }
}

protocol FeedCellPhotoAttachmentViewModel {
    var photoUrlString: String? { get }
    var width: Float { get }
    var height: Float { get }
}

final class FeedCell: UITableViewCell {
    
    static let reuseId = "FeedCell"
    
    @IBOutlet private var cardView: UIView!
    @IBOutlet private var iconImageView: WebImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var postLabel: UILabel!
    @IBOutlet private var moreTextButton: UIButton!
    @IBOutlet private var photoImageView: WebImageView!
    @IBOutlet private var likesLabel: UILabel!
    @IBOutlet private var commentsLabel: UILabel!
    @IBOutlet private var sharesLabel: UILabel!
    @IBOutlet private var viewsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        iconImageView.layer.cornerRadius = iconImageView.frame.width/2
        iconImageView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconImageView.set(imageUrl: nil)
        photoImageView.set(imageUrl: nil)
    }
    
    func set(viewModel: FeedCellViewModel) {
        iconImageView.set(imageUrl: viewModel.iconUrlString)
        nameLabel.text = viewModel.name
        dateLabel.text = viewModel.date
        postLabel.text = viewModel.text
        if let photoAttachment = viewModel.photoAttachment {
            photoImageView.set(imageUrl: photoAttachment.photoUrlString)
            photoImageView.isHidden = false
        } else {
            photoImageView.isHidden = true
        }
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
    }
    
    
    
}
