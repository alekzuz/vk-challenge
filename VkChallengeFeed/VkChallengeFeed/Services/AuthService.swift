//
//  AuthService.swift
//  VkChallengeFeed
//
//  Created by Алексей Сахаров on 09/11/2018.
//  Copyright © 2018 sakharov. All rights reserved.
//

import Foundation
import VKSdkFramework


protocol AuthServiceDelegate: class {
	func authServiceShouldShow(_ viewController: UIViewController)
	func authServiceDidSignIn()
	func authServiceDidSignInFail()
}

final class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
	private let appId = "6746223"
	private let vkSdk: VKSdk
	
	var delegate: AuthServiceDelegate?
	
	override init() {
		vkSdk = VKSdk.initialize(withAppId: appId)
		super.init()
		vkSdk.register(self)
		vkSdk.uiDelegate = self
	}
	
    var token: String? {
        return VKSdk.accessToken()?.accessToken
    }
    
	func wakeUpSession() {
		let scope = ["offline", "wall", "friends"]
		VKSdk.wakeUpSession(scope, complete: { [delegate] state, error in
			if state == VKAuthorizationState.authorized {
				delegate?.authServiceDidSignIn()
			} else if state == VKAuthorizationState.initialized {
				print("ready to authorize")
				VKSdk.authorize(scope)
			} else {
				print("auth problems, state: \(state) error: \(String(describing: error))")
				delegate?.authServiceDidSignInFail()
			}
		})
	}
	
	// MARK: - VKSdkDelegate
	
	func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
		delegate?.authServiceDidSignIn()
	}
	
	func vkSdkUserAuthorizationFailed() {
		print(#function)
	}
	
	// MARK: - VKSdkUIDelegate
	
	func vkSdkShouldPresent(_ controller: UIViewController!) {
		delegate?.authServiceShouldShow(controller)
	}
	
	func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
		print(#function)
	}
	
}
