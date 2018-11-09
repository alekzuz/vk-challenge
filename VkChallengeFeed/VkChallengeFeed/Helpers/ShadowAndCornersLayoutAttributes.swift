////
////  ShadowAndCornersLayoutAttributes.swift
////  VkChallengeFeed
////
////  Created by Алексей Сахаров on 09/11/2018.
////  Copyright © 2018 sakharov. All rights reserved.
////
//
//import UIKit
//
//class ShadowAndCornersLayoutAttributes: UICollectionViewLayoutAttributes {
//	struct ShadowInfo: Equatable {
//		let shadowColor: CGColor
//		let shadowOpacity: Float
//		let shadowOffset: CGSize
//		let shadowRadius: CGFloat
//	}
//
//	var roundedCorners: UIRectCorner = []
//	var roundedCornerRadius: CGFloat = 8
//	var shadowInfo: ShadowInfo?
//	var showSeparator: Bool = false
//
//	override func copy(with zone: NSZone? = nil) -> Any {
//		let aCopy = super.copy(with: zone) as! ShadowAndCornersLayoutAttributes
//		aCopy.roundedCorners = self.roundedCorners
//		aCopy.roundedCornerRadius = self.roundedCornerRadius
//		aCopy.shadowInfo = self.shadowInfo
//		aCopy.showSeparator = self.showSeparator
//		return aCopy
//	}
//
//	override func isEqual(_ object: Any?) -> Bool {
//		guard let rhs = object as? ShadowAndCornersLayoutAttributes else { return false }
//		return super.isEqual(rhs)
//			&& roundedCorners == rhs.roundedCorners
//			&& roundedCornerRadius == rhs.roundedCornerRadius
//			&& shadowInfo == rhs.shadowInfo
//			&& showSeparator == rhs.showSeparator
//	}
//}
//
//class CornerShadowedCollectionViewCell: UICollectionViewCell {
//
//	var couldHaveSeparators: Bool {
//		return true
//	}
//
//	lazy var separatorView: UIView = {
//		let view = UIView()
//		view.translatesAutoresizingMaskIntoConstraints = false
//		view.backgroundColor = .lightGray
//		view.frame.size.height = 0.5
//		self.contentView.addSubview(view)
//		return view
//	}()
//
//
//	override var isHighlighted: Bool {
//		didSet {
//			highlightCell(isHighlighted: isHighlighted)
//		}
//	}
//
//	override var isSelected: Bool {
//		didSet {
//			highlightCell(isHighlighted: isSelected)
//		}
//	}
//
//	func highlightCell(isHighlighted: Bool) {
//		if isHighlighted {
//			self.contentView.backgroundColor = .lightGray
//		} else {
//			self.contentView.backgroundColor = .white
//		}
//	}
//
//	override func prepareForReuse() {
//		super.prepareForReuse()
//		self.layer.mask = nil
//	}
//
//	override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
//		super.apply(layoutAttributes)
//
//		separatorView.isHidden = true
//		if let customAttributes = layoutAttributes as? ShadowAndCornersLayoutAttributes {
//			self.contentView.clipsToBounds = true
////			self.contentView.round(corners: customAttributes.roundedCorners, radius: customAttributes.roundedCornerRadius, bounds: bounds)
//			if let shadowInfo = customAttributes.shadowInfo {
//				clipsToBounds = false
//				layer.shadowColor = shadowInfo.shadowColor
//				layer.shadowOpacity = shadowInfo.shadowOpacity
//				layer.shadowOffset = shadowInfo.shadowOffset
//				layer.shadowRadius = shadowInfo.shadowRadius
//			}
//
//			separatorView.isHidden = !customAttributes.showSeparator || !couldHaveSeparators
//		}
//	}
//
//	override func layoutSubviews() {
//		super.layoutSubviews()
//		separatorView.frame.origin.x = 16
//		separatorView.frame.origin.y = self.bounds.height - separatorView.frame.size.height
//		separatorView.frame.size.width = self.bounds.width - separatorView.frame.origin.x
//	}
//}
//
