//
//  FeedViewController.swift
//  VkChallengeFeed
//
//  Created by Aleksei Sakharov on 09/11/2018.
//  Copyright © 2018 sakharov. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController {

    private var networkService: NetworkService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let authService = AppDelegate.shared().authService!
        networkService = NetworkService(authService: authService)
        networkService.getFeed(completion: { (feedResponse) in
            
        }, failure: {
            
        })
    }


}

