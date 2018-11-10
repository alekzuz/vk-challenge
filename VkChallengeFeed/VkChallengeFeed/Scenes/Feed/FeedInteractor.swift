//
//  FeedInteractor.swift
//  VkChallengeFeed
//
//  Created by Aleksei Sakharov on 10/11/2018.
//  Copyright © 2018 sakharov. All rights reserved.
//

import Foundation

protocol FeedBusinessLogic: class {
    func getFeed()
}

final class FeedInteractor: FeedBusinessLogic {
    private let presenter: FeedPresentationLogic
    private let networkService: NetworkService
    
    init(presenter: FeedPresentationLogic, networkService: NetworkService) {
        self.presenter = presenter
        self.networkService = networkService
    }
    
    func getFeed() {
        networkService.getFeed(completion: { [weak self] feedResponse in
            self?.presenter.presentFeed(feedResponse)
        }, failure: {
            //todo
        })
    }
    
}
