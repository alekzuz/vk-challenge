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
    var likes: String? { get }
    var comments: String? { get }
    var shares: String? { get }
    var views: String? { get }
    var photoAttachments: [FeedCellPhotoAttachmentViewModel] { get }
    var sizes: FeedCellSizes { get }
}

protocol FeedCellSizes {
    var postLabelFrame: CGRect { get }
    var moreTextButtonFrame: CGRect { get }
    var attachmentFrame: CGRect { get }
    var galleryItemSize: CGSize { get }
    var counterPlaceholderFrame: CGRect { get }
    var totalHeight: CGFloat { get }
}

protocol FeedCellPhotoAttachmentViewModel {
    var photoUrlString: String? { get }
    var width: Float { get }
    var height: Float { get }
}

protocol FeedCellDelegate: class {
    func revealPost(for cell:FeedCell)
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
    private var galleryView: GalleryView!
    @IBOutlet private var countersPlaceholder: UIView!
    @IBOutlet private var likesLabel: UILabel!
    @IBOutlet private var commentsLabel: UILabel!
    @IBOutlet private var sharesLabel: UILabel!
    @IBOutlet private var viewsLabel: UILabel!
    
    weak var delegate: FeedCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.cornerRadius = 10
        cardView.clipsToBounds = true
        iconImageView.layer.cornerRadius = iconImageView.frame.width/2
        iconImageView.clipsToBounds = true
        galleryView = GalleryView.loadFromNib()
        cardView.addSubview(galleryView)
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
        postLabel.frame = viewModel.sizes.postLabelFrame
        moreTextButton.frame = viewModel.sizes.moreTextButtonFrame
        
        // сорян за говнокод, времени очень мало =(
        if let photoAttachment = viewModel.photoAttachments.first, viewModel.photoAttachments.count == 1 {
            photoImageView.set(imageUrl: photoAttachment.photoUrlString)
            photoImageView.isHidden = false
            photoImageView.frame = viewModel.sizes.attachmentFrame
            
            galleryView.isHidden = true
        } else if viewModel.photoAttachments.count > 1 {
            photoImageView.backgroundColor = UIColor.green
            photoImageView.frame = viewModel.sizes.attachmentFrame
            
            galleryView.isHidden = false
            galleryView.frame = viewModel.sizes.attachmentFrame
            
            galleryView.setItemSize(viewModel.sizes.galleryItemSize)
            galleryView.set(photos: viewModel.photoAttachments)
        } else {
            photoImageView.isHidden = true
            galleryView.isHidden = true
        }
        
        likesLabel.text = viewModel.likes
        commentsLabel.text = viewModel.comments
        sharesLabel.text = viewModel.shares
        viewsLabel.text = viewModel.views
        
        countersPlaceholder.frame = viewModel.sizes.counterPlaceholderFrame
    }
    
    @IBAction private func moreTextButtonTouch() {
        delegate?.revealPost(for: self)
    }
    
}
