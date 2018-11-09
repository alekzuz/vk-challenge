//
//  AuthViewController.swift
//  VkChallengeFeed
//
//  Created by Алексей Сахаров on 09/11/2018.
//  Copyright © 2018 sakharov. All rights reserved.
//

import UIKit

final class AuthViewController: UIViewController {
	
	private var authService: AuthService!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		authService = AppDelegate.shared().authService
		authService.wakeUpSession()
	}
	
	@IBAction func signInTouch() {
		authService.wakeUpSession()
	}
		
}
