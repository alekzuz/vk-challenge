//
//  FooterView.swift
//  VkChallengeFeed
//
//  Created by Aleksei Sakharov on 11/11/2018.
//  Copyright © 2018 sakharov. All rights reserved.
//

import UIKit

final class FooterView: UIView {
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var loader: UIActivityIndicatorView!
    
    func setTitle(_ title: String?) {
        titleLabel.text = title
        loader.stopAnimating()
    }
    
    func showLoader() {
        loader.startAnimating()
        titleLabel.text = nil
    }
    
}
