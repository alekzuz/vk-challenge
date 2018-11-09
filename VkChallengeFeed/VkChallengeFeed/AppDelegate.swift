//
//  AppDelegate.swift
//  VkChallengeFeed
//
//  Created by Aleksei Sakharov on 09/11/2018.
//  Copyright © 2018 sakharov. All rights reserved.
//

import UIKit
import VKSdkFramework

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AuthServiceDelegate {

    var window: UIWindow?

	var authService: AuthService!
	
	static func shared() -> AppDelegate {
		return UIApplication.shared.delegate as! AppDelegate
	}

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		self.window = UIWindow()
		self.authService = AuthService()
		authService?.delegate = self
		
		let authVC: AuthViewController = AuthViewController.loadFromStoryboard()
		self.window?.rootViewController = authVC
		self.window?.makeKeyAndVisible()
		
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        VKSdk.processOpen(url, fromApplication: UIApplication.OpenURLOptionsKey.sourceApplication.rawValue)        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

	// MARK: - AuthServiceDelegate
	
	func authServiceShouldShow(_ viewController: UIViewController) {
		window?.rootViewController?.present(viewController, animated: true, completion: nil)
	}
	
	func authServiceDidSignIn() {
		if !(window?.rootViewController is FeedViewController) {
			window?.rootViewController = FeedViewController.loadFromStoryboard()
		}
	}
	
	func authServiceDidSignInFail() {
		if !(window?.rootViewController is AuthViewController) {
			window?.rootViewController = AuthViewController.loadFromStoryboard()
		}
	}
	
}

