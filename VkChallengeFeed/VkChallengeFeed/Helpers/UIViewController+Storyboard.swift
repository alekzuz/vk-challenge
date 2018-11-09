//
//  UIViewController+Storyboard.swift
//  VkChallengeFeed
//
//  Created by Алексей Сахаров on 09/11/2018.
//  Copyright © 2018 sakharov. All rights reserved.
//

import UIKit

extension UIViewController {
	
	class func loadFromStoryboard<Self: UIViewController>() -> Self {
		let name = String(describing: self)
		let storyboard = UIStoryboard(name: name, bundle: nil)
		if let viewController = storyboard.instantiateInitialViewController() as? Self {
			return viewController
		} else {
			fatalError("Error: No initial view controller in \(name) storyboard!")
		}
	}
	
}
