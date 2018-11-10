//
//  String+Helpers.swift
//  VkChallengeFeed
//
//  Created by Aleksei Sakharov on 10/11/2018.
//  Copyright © 2018 sakharov. All rights reserved.
//

import UIKit

extension String {
    
    func height(fittingWidth width: CGFloat, font: UIFont) -> CGFloat {
        let fittingSize = CGSize(width: width, height: .greatestFiniteMagnitude)
        let size = self.boundingRect(with: fittingSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(size.height)
    }
    
}
