////
////  CustomLayout.swift
////  VkChallengeFeed
////
////  Created by Алексей Сахаров on 09/11/2018.
////  Copyright © 2018 sakharov. All rights reserved.
////
//
//import UIKit
//
//final class AddCargoCollectionViewLayout: UICollectionViewFlowLayout {
//
//	override class var layoutAttributesClass: Swift.AnyClass {
//		return ShadowAndCornersLayoutAttributes.self
//	}
//
//	override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
//		let arr = super.layoutAttributesForElements(in: rect)
//		return arr?.map { atts in
//			if atts.representedElementCategory == .cell {
//				return self.layoutAttributesForItem(at: atts.indexPath)!
//			} else {
//				return atts
//			}
//		}
//	}
//
//	override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
//		var attributes = super.layoutAttributesForItem(at: indexPath) as! ShadowAndCornersLayoutAttributes
//		attributes = attributes.copy() as! ShadowAndCornersLayoutAttributes
//
//		attributes.roundedCorners = [.topLeft, .topRight, .bottomLeft, .bottomRight]
//		let shadowInfo = ShadowAndCornersLayoutAttributes.ShadowInfo(shadowColor: UIColor.gray.cgColor,
//																	 shadowOpacity: 0.3,
//																	 shadowOffset: CGSize(width: 0, height: 2),
//																	 shadowRadius: 4)
//		attributes.shadowInfo = shadowInfo
//
//		return attributes
//	}
//
//}
