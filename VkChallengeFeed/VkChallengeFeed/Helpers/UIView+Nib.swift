//
//  UIView+Nib.swift
//  VkChallengeFeed
//
//  Created by Aleksei Sakharov on 11/11/2018.
//  Copyright © 2018 sakharov. All rights reserved.
//

import UIKit

extension UIView {
    
    class func loadFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
    
}
