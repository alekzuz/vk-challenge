//
//  GradientView.swift
//  VkChallengeFeed
//
//  Created by Алексей Сахаров on 09/11/2018.
//  Copyright © 2018 sakharov. All rights reserved.
//

import UIKit

class GradientView: UIView {
	
	var orientation = GradientOrientation.vertical {
		didSet {
			setupGradient()
		}
	}
	
	enum GradientOrientation: Int {
		case vertical
		case degree45
	}
	
	@IBInspectable var startColor: UIColor? {
		didSet {
			setupGradientColors()
		}
	}
	@IBInspectable var endColor: UIColor? {
		didSet {
			setupGradientColors()
		}
	}
	private let gradientLayer = CAGradientLayer()
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupGradient()
	}
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupGradient()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		gradientLayer.frame = bounds
	}
	
	// MARK: - Setup Gradient
	
	private func setupGradient() {
		self.layer.addSublayer(gradientLayer)
		setupGradientColors()
		setupOrientation()
		gradientLayer.shouldRasterize = true
		gradientLayer.rasterizationScale = UIScreen.main.scale
	}
	
	private func setupGradientColors() {
		if let startColor = startColor, let endColor = endColor {
			gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
		}
	}
	
	private func setupOrientation() {
		switch orientation {
		case .vertical:
			gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
			gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
		case .degree45:
			gradientLayer.startPoint = CGPoint(x: 0.1, y: 0.1)
			gradientLayer.endPoint = CGPoint(x: 0.9, y: 0.9)
		}
	}
	
}

