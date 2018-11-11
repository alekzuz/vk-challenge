//
//  InsetableTextField.swift
//  VkChallengeFeed
//
//  Created by Aleksei Sakharov on 11/11/2018.
//  Copyright © 2018 sakharov. All rights reserved.
//

import UIKit

final class InsetableTextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 36, dy: 0)
    }
 
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 36, dy: 0)
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var rect =  super.leftViewRect(forBounds: bounds)
        rect.origin.x += 12
        return rect
    }
        
}
