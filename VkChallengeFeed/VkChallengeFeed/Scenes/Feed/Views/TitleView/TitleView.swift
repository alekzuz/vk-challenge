//
//  TitleView.swift
//  VkChallengeFeed
//
//  Created by Aleksei Sakharov on 11/11/2018.
//  Copyright © 2018 sakharov. All rights reserved.
//

import UIKit

protocol TitleViewViewModel {
    var photoUrlString: String? { get }
}

final class TitleView: UIView {

    @IBOutlet private var textField: UITextField!
    @IBOutlet private var avatarView: WebImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textField.borderStyle = .none
        textField.layer.cornerRadius = 10
        textField.layer.masksToBounds = true
        
        let image = UIImage(named: "search")
        textField.leftView = UIImageView(image: image)
        textField.leftView?.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        textField.leftViewMode = .always
        
        avatarView.layer.cornerRadius = avatarView.frame.width/2
        avatarView.clipsToBounds = true
    }
    
    override var intrinsicContentSize: CGSize {
        return UIView.layoutFittingExpandedSize
    }
    
    func set(userViewModel: TitleViewViewModel) {
        avatarView.set(imageUrl: userViewModel.photoUrlString)
    }
    
}
